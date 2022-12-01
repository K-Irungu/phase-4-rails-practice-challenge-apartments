class LeasesController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
    

    # POST '/leases'
    def create
        lease = Lease.create!(lease_params)
        render json: lease.apartment, status: :created
    end

    # DELETE '/leases/:id'
    def destroy
        lease = Lease.find(params[:id])
        lease.destroy
        head :no_content
    end


    private
    def render_record_not_found
        render json: { error: "Lease not found" }, status: :not_found
    end

    def render_unprocessable_entity(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

    def lease_params
        params.permit(:rent, :apartment_id, :tenant_id)
    end

end
