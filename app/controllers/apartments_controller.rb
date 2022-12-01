class ApartmentsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

    # GET '/apartments'
    def index
        apartments = Apartment.all
        render json: apartments, each_serializer: ApartmentSerializer, status: :ok
    end

    # GET '/apartments/:id'
    def show
        apartment = Apartment.find(params[:id])
        render json: apartment, status: :ok
    end

    # POST '/apartments'
    def create
        apartment = Apartment.create!(apartment_params)
        render json: apartment, status: :created
    end

    # PATCH '/apartments/:id'
    def update
        apartment = Apartment.find(params[:id])
        apartment.update!(apartment_params)
        render json: apartment, status: :ok
    end

    # DELETE '/apartments/:id'
    def destroy
        apartment = Apartment.find(params[:id])
        apartment.destroy
        head :no_content
    end

    private
    def apartment_params
        params.permit(:number)
    end

    def render_record_not_found
        render json: { error: "Apartment not found" }, status: :not_found
    end

    def render_unprocessable_entity(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end
end
