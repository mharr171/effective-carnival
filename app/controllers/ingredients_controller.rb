class IngredientsController < ApiController
  # POST /api/drink/:id/ingredients
  def create
    @drink = Drink.find(params[:drink_id])
    @ingredient = @drink.ingredients.build(ingredient_params)

    if @ingredient.save
      render json: @ingredient
    else
      render json: { errors: @list.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PUT /api/ingredients/:id
  def update
    @ingredient = Ingredient.find(params[:id])
    if @ingredient.update(ingredient_params)
      render json: @ingredient
    else
      render json: { errors: @ingredient.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /api/ingredients/:id
  def destroy
    begin
      @ingredient = Ingredient.find(params[:id])
      @ingredient.destroy

      render json: {}, status: :no_content
    rescue ActiveRecord::RecordNotFound
      render :json => {}, :status => :not_found
    end
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:description)
  end
end