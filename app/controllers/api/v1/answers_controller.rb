module Api
  module V1
    class AnswersController < FmBaseController

      before_action :authenticate!
      before_action :set_answer, only: [:show, :update, :destroy]

      # GET /answers.json
      # DOC GENERATED AUTOMATICALLY: REMOVE THIS LINE TO PREVENT REGENARATING NEXT TIME
      api :GET, '/v1/answers', 'List answers'
      def index
        @answers = Answer.for_user(current_user)
      end

      # GET /answers/1.json
      # DOC GENERATED AUTOMATICALLY: REMOVE THIS LINE TO PREVENT REGENARATING NEXT TIME
      api :GET, '/v1/answers/:id', 'Show an answer'
      def show
      end

      # POST /answers.json
      def create
        @answer = Answer.new(answer_params)

        if @answer.save_with_user(current_user)
          render :show, status: :created, location: [:api, :v1, @answer]
        else
          render json: @answer.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /answers/1.json
      def update
        if @answer.update_with_user(current_user, answer_params)
          render :show, status: :ok, location: [:api, :v1, @answer]
        else
          render json: @answer.errors, status: :unprocessable_entity
        end
      end

      # DELETE /answers/1.json
      # DOC GENERATED AUTOMATICALLY: REMOVE THIS LINE TO PREVENT REGENARATING NEXT TIME
      api :DELETE, '/v1/answers/:id', 'Destroy an answer'
      def destroy
        @answer.destroy_with_user(current_user)
        head :no_content
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_answer
          @answer = Answer.for_user(current_user).find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def answer_params
          params.require(:answer).permit(:text, :information_type_id)
        end
    end
  end
end
