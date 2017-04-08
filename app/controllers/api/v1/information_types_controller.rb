module Api
  module V1
    class InformationTypesController < FmBaseController

      before_action :authenticate!
      before_action :set_information_type, only: [:show, :update, :destroy]

      # GET /information_types.json
      # DOC GENERATED AUTOMATICALLY: REMOVE THIS LINE TO PREVENT REGENARATING NEXT TIME
      api :GET, '/v1/information_types', 'List information types'
      def index
        @information_types = InformationType.for_user(current_user)
      end

      # GET /information_types/1.json
      # DOC GENERATED AUTOMATICALLY: REMOVE THIS LINE TO PREVENT REGENARATING NEXT TIME
      api :GET, '/v1/information_types/:id', 'Show an information type'
      def show
      end

      # POST /information_types.json
      def create
        @information_type = InformationType.new(information_type_params)

        if @information_type.save_with_user(current_user)
          render :show, status: :created, location: [:api, :v1, @information_type]
        else
          render json: @information_type.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /information_types/1.json
      def update
        if @information_type.update_with_user(current_user, information_type_params)
          render :show, status: :ok, location: [:api, :v1, @information_type]
        else
          render json: @information_type.errors, status: :unprocessable_entity
        end
      end

      # DELETE /information_types/1.json
      # DOC GENERATED AUTOMATICALLY: REMOVE THIS LINE TO PREVENT REGENARATING NEXT TIME
      api :DELETE, '/v1/information_types/:id', 'Destroy an information type'
      def destroy
        @information_type.destroy_with_user(current_user)
        head :no_content
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_information_type
          @information_type = InformationType.for_user(current_user).find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def information_type_params
          params.require(:information_type).permit(:title)
        end
    end
  end
end
