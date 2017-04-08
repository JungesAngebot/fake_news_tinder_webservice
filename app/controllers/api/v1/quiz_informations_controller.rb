module Api
  module V1
    class QuizInformationsController < FmBaseController

      before_action :authenticate!
      before_action :set_quiz_information, only: [:show, :update, :destroy]

      # GET /quiz_informations.json
      # DOC GENERATED AUTOMATICALLY: REMOVE THIS LINE TO PREVENT REGENARATING NEXT TIME
      api :GET, '/v1/quiz_informations', 'List quiz informations'
      def index
        @quiz_informations = QuizInformation.for_user(current_user)
      end

      # GET /quiz_informations/1.json
      # DOC GENERATED AUTOMATICALLY: REMOVE THIS LINE TO PREVENT REGENARATING NEXT TIME
      api :GET, '/v1/quiz_informations/:id', 'Show a quiz information'
      def show
      end

      # POST /quiz_informations.json
      def create
        @quiz_information = QuizInformation.new(quiz_information_params)

        if @quiz_information.save_with_user(current_user)
          render :show, status: :created, location: [:api, :v1, @quiz_information]
        else
          render json: @quiz_information.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /quiz_informations/1.json
      def update
        if @quiz_information.update_with_user(current_user, quiz_information_params)
          render :show, status: :ok, location: [:api, :v1, @quiz_information]
        else
          render json: @quiz_information.errors, status: :unprocessable_entity
        end
      end

      # DELETE /quiz_informations/1.json
      # DOC GENERATED AUTOMATICALLY: REMOVE THIS LINE TO PREVENT REGENARATING NEXT TIME
      api :DELETE, '/v1/quiz_informations/:id', 'Destroy a quiz information'
      def destroy
        @quiz_information.destroy_with_user(current_user)
        head :no_content
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_quiz_information
          @quiz_information = QuizInformation.for_user(current_user).find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def quiz_information_params
          params.require(:quiz_information).permit(:quiz_id, :information_id)
        end
    end
  end
end
