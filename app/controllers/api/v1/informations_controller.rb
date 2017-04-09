module Api
  module V1
    class InformationsController < FmBaseController

      before_action :authenticate!
      before_action :set_information, only: [:show, :update, :destroy]

      # GET /informations.json
      # DOC GENERATED AUTOMATICALLY: REMOVE THIS LINE TO PREVENT REGENARATING NEXT TIME
      api :GET, '/v1/informations', 'List informations'
      def index
        @informations = Information.for_user(current_user)
      end

      # GET /informations/1.json
      # DOC GENERATED AUTOMATICALLY: REMOVE THIS LINE TO PREVENT REGENARATING NEXT TIME
      api :GET, '/v1/informations/:id', 'Show an information'
      def show
      end

      # POST /informations.json
      def create
        @information = Information.new(information_params)

        if @information.save_with_user(current_user)
          render :show, status: :created, location: [:api, :v1, @information]
        else
          render json: @information.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /informations/1.json
      def update
        if @information.update_with_user(current_user, information_params)
          render :show, status: :ok, location: [:api, :v1, @information]
        else
          render json: @information.errors, status: :unprocessable_entity
        end
      end

      # DELETE /informations/1.json
      # DOC GENERATED AUTOMATICALLY: REMOVE THIS LINE TO PREVENT REGENARATING NEXT TIME
      api :DELETE, '/v1/informations/:id', 'Destroy an information'
      def destroy
        @information.destroy_with_user(current_user)
        head :no_content
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_information
          @information = Information.for_user(current_user).find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def information_params
          params.require(:information).permit(:challenge_text, :result_text, :information_type_id, :source_link, :correct_answer_id, :category_id)
        end
    end
  end
end
