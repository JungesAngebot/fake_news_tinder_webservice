module Api
  module V1
    class CategoriesController < FmBaseController

      before_action :authenticate!
      before_action :set_category, only: [:show, :update, :destroy]

      # GET /categories.json
      # DOC GENERATED AUTOMATICALLY: REMOVE THIS LINE TO PREVENT REGENARATING NEXT TIME
      api :GET, '/v1/categories', 'List categories'
      def index
        @categories = Category.for_user(current_user)
      end

      # GET /categories/1.json
      # DOC GENERATED AUTOMATICALLY: REMOVE THIS LINE TO PREVENT REGENARATING NEXT TIME
      api :GET, '/v1/categories/:id', 'Show a category'
      def show
      end

      # POST /categories.json
      def create
        @category = Category.new(category_params)

        if @category.save_with_user(current_user)
          render :show, status: :created, location: [:api, :v1, @category]
        else
          render json: @category.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /categories/1.json
      def update
        if @category.update_with_user(current_user, category_params)
          render :show, status: :ok, location: [:api, :v1, @category]
        else
          render json: @category.errors, status: :unprocessable_entity
        end
      end

      # DELETE /categories/1.json
      # DOC GENERATED AUTOMATICALLY: REMOVE THIS LINE TO PREVENT REGENARATING NEXT TIME
      api :DELETE, '/v1/categories/:id', 'Destroy a category'
      def destroy
        @category.destroy_with_user(current_user)
        head :no_content
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_category
          @category = Category.for_user(current_user).find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def category_params
          params.require(:category).permit(:title)
        end
    end
  end
end
