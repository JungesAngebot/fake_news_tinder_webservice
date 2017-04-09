module Admin
  class InformationsController < FmBaseController
    layout 'admin/admin'

    before_action :authenticate_admin!

    before_action :set_information, only: [:show, :edit, :update, :destroy]

    # GET /informations
    # GET /informations.json
    def index
      @informations = Information.all
      @informations = filter_simple_search(@informations, :id)
    end

    # GET /informations/1
    # GET /informations/1.json
    def show
    end

    # GET /informations/new
    def new
      @information = Information.new
    end

    # GET /informations/1/edit
    def edit
    end

    # POST /informations
    # POST /informations.json
    def create
      @information = Information.new(information_params)

      respond_to do |format|
        if @information.save
          format.html { redirect_to edit_admin_information_path(@information), notice: 'Information was successfully created.' }
          format.json { render :show, status: :created, location: @information }
        else
          format.html { render :new }
          format.json { render json: @information.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /informations/1
    # PATCH/PUT /informations/1.json
    def update
      respond_to do |format|
        if @information.update(information_params)
          format.html { redirect_to edit_admin_information_path(@information), notice: 'Information was successfully updated.' }
          format.json { render :show, status: :ok, location: @information }
        else
          format.html { render :edit }
          format.json { render json: @information.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /informations/1
    # DELETE /informations/1.json
    def destroy
      @information.destroy
      respond_to do |format|
        format.html { redirect_to admin_informations_url }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_information
        @information = Information.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def information_params
        params.require(:information).permit(:challenge_text, :result_text, :information_type_id, :source_link, :correct_answer_id, :category_id)
      end
  end
end
