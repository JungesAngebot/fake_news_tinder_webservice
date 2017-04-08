module Admin
  class QuizInformationsController < FmBaseController
    layout 'admin/admin'

    before_action :authenticate_admin!

    before_action :set_quiz_information, only: [:show, :edit, :update, :destroy]

    # GET /quiz_informations
    # GET /quiz_informations.json
    def index
      @quiz_informations = QuizInformation.all
      @quiz_informations = filter_simple_search(@quiz_informations, :id)
    end

    # GET /quiz_informations/1
    # GET /quiz_informations/1.json
    def show
    end

    # GET /quiz_informations/new
    def new
      @quiz_information = QuizInformation.new
    end

    # GET /quiz_informations/1/edit
    def edit
    end

    # POST /quiz_informations
    # POST /quiz_informations.json
    def create
      @quiz_information = QuizInformation.new(quiz_information_params)

      respond_to do |format|
        if @quiz_information.save
          format.html { redirect_to edit_admin_quiz_information_path(@quiz_information), notice: 'Quiz information was successfully created.' }
          format.json { render :show, status: :created, location: @quiz_information }
        else
          format.html { render :new }
          format.json { render json: @quiz_information.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /quiz_informations/1
    # PATCH/PUT /quiz_informations/1.json
    def update
      respond_to do |format|
        if @quiz_information.update(quiz_information_params)
          format.html { redirect_to edit_admin_quiz_information_path(@quiz_information), notice: 'Quiz information was successfully updated.' }
          format.json { render :show, status: :ok, location: @quiz_information }
        else
          format.html { render :edit }
          format.json { render json: @quiz_information.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /quiz_informations/1
    # DELETE /quiz_informations/1.json
    def destroy
      @quiz_information.destroy
      respond_to do |format|
        format.html { redirect_to admin_quiz_informations_url }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_quiz_information
        @quiz_information = QuizInformation.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def quiz_information_params
        params.require(:quiz_information).permit(:quiz_id, :information_id)
      end
  end
end
