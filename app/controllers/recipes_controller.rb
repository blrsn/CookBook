class RecipesController < ApplicationController
  before_action :get_recipe,only: [:show,:edit,:update,:destroy]
  
  def new
    @recipe = Recipe.new
  end
  
  def create
    @recipe = Recipe.new(recipe_params)
    
    if @recipe.save
      redirect_to @recipe 
      flash[:success] = "Recipe saved successfully"
    else
      flash.now[:danger] = "Please enter valid information"
      render 'new'
    end
  end
  
  def show
  end
  
  def edit
  end
  
  def update
    if @recipe.update(recipe_params)
      redirect_to @recipe
      flash[:success] = "Recipe updated successfully"
    else
      flash.now[:danger] = "Please enter valid information"
      render "edit"
    end
  end
  
  def destroy
    @recipe.destroy
    redirect_to root_path
    flash[:success] = "Successfully deleted recipe"
  end
  
  def index
    @recipes = Recipe.all.order("created_at DESC")
  end
  
  private
  
  def get_recipe
    @recipe = Recipe.find(params[:id])
  end
  
  def recipe_params
    params.require(:recipe).permit(:title,:description,:image, ingredients_attributes: [:id, :name, :destroy], directions_attributes: [:id, :step, :destroy])
  end
  
end
