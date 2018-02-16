class DrinksController < ApiController
  # GET /drinks
  def index
    @drinks = Drink.select("id, title").all
    render json: @drinks.to_json
  end

  # GET /drinks/:id
  def show
    @drink = Drink.find(params[:id])
    render json: @drink.to_json(:include => { :ingredients => { :only => [:id, :description] }})
  end

  # POST /api/drinks
  def create
    @drink = Drink.new(drink_params)

    if @drink.save
      render json: @drink
    else
      render json: { errors: @list.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PUT /api/drinks/:id
  def update
    @drink = Drink.find(params[:id])
    if @drink.update(drink_params)
      render json: @drink
    else
      render json: { errors: @drink.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /api/drinks/:id
  def destroy
    begin
      @drink = Drink.find(params[:id])
      @drink.destroy

      render json: {}, status: :no_content
    rescue ActiveRecord::RecordNotFound
      render :json => {}, :status => :not_found
    end
  end

  private

  def drink_params
    params.require(:drink).permit(:title, :description, :steps, :source)
  end
end