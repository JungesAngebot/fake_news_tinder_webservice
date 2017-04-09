module Api
  module V1
    class MemesController < FmBaseController

      before_action :authenticate!
      before_action :set_meme, only: [:show, :update, :destroy]

      # GET /memes.json
      # DOC GENERATED AUTOMATICALLY: REMOVE THIS LINE TO PREVENT REGENARATING NEXT TIME
      api :GET, '/v1/memes', 'List memes'
      def index
        @memes = Meme.for_user(current_user)
      end

      # GET /memes/1.json
      # DOC GENERATED AUTOMATICALLY: REMOVE THIS LINE TO PREVENT REGENARATING NEXT TIME
      api :GET, '/v1/memes/:id', 'Show a meme'
      def show
      end

      # POST /memes.json
      def create
        @meme = Meme.new(meme_params)

        if @meme.save_with_user(current_user)
          render :show, status: :created, location: [:api, :v1, @meme]
        else
          render json: @meme.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /memes/1.json
      def update
        if @meme.update_with_user(current_user, meme_params)
          render :show, status: :ok, location: [:api, :v1, @meme]
        else
          render json: @meme.errors, status: :unprocessable_entity
        end
      end

      # DELETE /memes/1.json
      # DOC GENERATED AUTOMATICALLY: REMOVE THIS LINE TO PREVENT REGENARATING NEXT TIME
      api :DELETE, '/v1/memes/:id', 'Destroy a meme'
      def destroy
        @meme.destroy_with_user(current_user)
        head :no_content
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_meme
          @meme = Meme.for_user(current_user).find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def meme_params
          params.require(:meme).permit(:image_url, :category_id, :min_correct_including, :max_correct_excluding)
        end
    end
  end
end
