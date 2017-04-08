module Admin
  class MemesController < FmBaseController
    layout 'admin/admin'

    before_action :authenticate_admin!

    before_action :set_meme, only: [:show, :edit, :update, :destroy]

    # GET /memes
    # GET /memes.json
    def index
      @memes = Meme.all
      @memes = filter_simple_search(@memes, :id)
    end

    # GET /memes/1
    # GET /memes/1.json
    def show
    end

    # GET /memes/new
    def new
      @meme = Meme.new
    end

    # GET /memes/1/edit
    def edit
    end

    # POST /memes
    # POST /memes.json
    def create
      @meme = Meme.new(meme_params)

      respond_to do |format|
        if @meme.save
          format.html { redirect_to edit_admin_meme_path(@meme), notice: 'Meme was successfully created.' }
          format.json { render :show, status: :created, location: @meme }
        else
          format.html { render :new }
          format.json { render json: @meme.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /memes/1
    # PATCH/PUT /memes/1.json
    def update
      respond_to do |format|
        if @meme.update(meme_params)
          format.html { redirect_to edit_admin_meme_path(@meme), notice: 'Meme was successfully updated.' }
          format.json { render :show, status: :ok, location: @meme }
        else
          format.html { render :edit }
          format.json { render json: @meme.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /memes/1
    # DELETE /memes/1.json
    def destroy
      @meme.destroy
      respond_to do |format|
        format.html { redirect_to admin_memes_url }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_meme
        @meme = Meme.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def meme_params
        params.require(:meme).permit(:image_url, :category_id, :min_correct_including, :max_correct_excluding)
      end
  end
end
