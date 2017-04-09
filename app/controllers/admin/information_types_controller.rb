module Admin
  class InformationTypesController < FmBaseController
    layout 'admin/admin'

    before_action :authenticate_admin!

    before_action :set_information_type, only: [:show, :edit, :update, :destroy]

    # GET /information_types
    # GET /information_types.json
    def index
      @information_types = InformationType.all
      @information_types = filter_simple_search(@information_types, :id)
    end

    # GET /information_types/1
    # GET /information_types/1.json
    def show
    end

    # GET /information_types/new
    def new
      @information_type = InformationType.new
    end

    # GET /information_types/1/edit
    def edit
    end

    # POST /information_types
    # POST /information_types.json
    def create
      @information_type = InformationType.new(information_type_params)

      respond_to do |format|
        if @information_type.save
          format.html { redirect_to edit_admin_information_type_path(@information_type), notice: 'Information type was successfully created.' }
          format.json { render :show, status: :created, location: @information_type }
        else
          format.html { render :new }
          format.json { render json: @information_type.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /information_types/1
    # PATCH/PUT /information_types/1.json
    def update
      respond_to do |format|
        if @information_type.update(information_type_params)
          format.html { redirect_to edit_admin_information_type_path(@information_type), notice: 'Information type was successfully updated.' }
          format.json { render :show, status: :ok, location: @information_type }
        else
          format.html { render :edit }
          format.json { render json: @information_type.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /information_types/1
    # DELETE /information_types/1.json
    def destroy
      @information_type.destroy
      respond_to do |format|
        format.html { redirect_to admin_information_types_url }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_information_type
        @information_type = InformationType.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def information_type_params
        params.require(:information_type).permit(:title)
      end
  end
end
