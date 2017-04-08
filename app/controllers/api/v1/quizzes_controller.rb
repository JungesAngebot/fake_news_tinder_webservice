module Api
  module V1
    class QuizzesController < FmBaseController

      before_action :authenticate!
      before_action :set_quiz, only: [:show, :update, :destroy]

      # GET /quizzes.json
      # DOC GENERATED AUTOMATICALLY: REMOVE THIS LINE TO PREVENT REGENARATING NEXT TIME
      api :GET, '/v1/quizzes', 'List quizzes'
      def index
        @quizzes = Quiz.for_user(current_user)
      end

      # GET /quizzes/1.json
      # DOC GENERATED AUTOMATICALLY: REMOVE THIS LINE TO PREVENT REGENARATING NEXT TIME
      api :GET, '/v1/quizzes/:id', 'Show a quiz'
      def show
      end

      # POST /quizzes.json
      def create
        @quiz = Quiz.new(quiz_params)

        if @quiz.save_with_user(current_user)
          render :show, status: :created, location: [:api, :v1, @quiz]
        else
          render json: @quiz.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /quizzes/1.json
      def update
        if @quiz.update_with_user(current_user, quiz_params)
          render :show, status: :ok, location: [:api, :v1, @quiz]
        else
          render json: @quiz.errors, status: :unprocessable_entity
        end
      end

      # DELETE /quizzes/1.json
      # DOC GENERATED AUTOMATICALLY: REMOVE THIS LINE TO PREVENT REGENARATING NEXT TIME
      api :DELETE, '/v1/quizzes/:id', 'Destroy a quiz'
      def destroy
        @quiz.destroy_with_user(current_user)
        head :no_content
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_quiz
          @quiz = Quiz.for_user(current_user).find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def quiz_params
          params.require(:quiz).permit(:title)
        end
    end
  end
end
