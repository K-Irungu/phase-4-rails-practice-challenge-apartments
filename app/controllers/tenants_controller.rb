class TenantsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
    
    # GET '/tenants'
    def index
        tenants = Tenant.all
        render json: tenants, status: :ok
    end

    # GET '/tenants/:id'
    def show
        tenant = Tenant.find(params[:id])
        render json: tenant, status: :ok
    end

    # POST '/tenants'
    def create
        tenant = Tenant.create!(tenant_params)
        render json: tenant, status: :created
    end

    # PATCH '/tenants/:id'
    def update
        tenant = Tenant.find(params[:id])
        tenant.update!(tenant_params)
        render json: tenant, status: :ok
    end

    # DELETE '/tenants/:id'
    def destroy
        tenant = Tenant.find(params[:id])
        tenant.destroy
        head :no_content
    end

    private
    def render_record_not_found
        render json: { error: "Tenant not found" }, status: :not_found
    end

    def render_unprocessable_entity(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

    def tenant_params
        params.permit(:name, :age)
    end

end
