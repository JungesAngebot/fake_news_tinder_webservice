module Api
  module V1
    class AnswerGivensController < FmBaseController

      before_action :authenticate!
      before_action :set_answer_given, only: [:show, :update, :destroy]

      # GET /answer_givens.json
      def index
        @answer_givens = AnswerGiven.for_user(current_user)
      end

      # GET /answer_givens/1.json
      def show
      end

      # POST /answer_givens.json
      # DOC GENERATED AUTOMATICALLY: REMOVE THIS LINE TO PREVENT REGENARATING NEXT TIME
      api :POST, '/v1/answer_givens', 'Create an answer given'
      param :answer_given, :boolean do
        param :answer_id, :boolean
        param :id, :boolean
        param :information_id, :boolean
        param :quiz_id, :boolean
        param :user_id, :boolean
      end
      def create
        @answer_given = AnswerGiven.new(answer_given_params)

        if @answer_given.save_with_user(current_user)
          render :show, status: :created, location: [:api, :v1, @answer_given]
        else
          render json: @answer_given.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /answer_givens/1.json
      def update
        if @answer_given.update_with_user(current_user, answer_given_params)
          render :show, status: :ok, location: [:api, :v1, @answer_given]
        else
          render json: @answer_given.errors, status: :unprocessable_entity
        end
      end

      # DELETE /answer_givens/1.json
      def destroy
        @answer_given.destroy_with_user(current_user)
        head :no_content
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_answer_given
          @answer_given = AnswerGiven.for_user(current_user).find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def answer_given_params
          params.require(:answer_given).permit(:user_id, :quiz_id, :information_id, :answer_id)
        end
    end
  end
end
