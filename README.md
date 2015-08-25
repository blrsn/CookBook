# Cook Book

### Description
This is a Ruby on Rails App where users can submit recipies along with descriptions, directions and image of the recipe. 
###Gems Used

1. *Paperclip* - To upload image to the Recipes table
2. *Cocoon* - Used to render a nested form
3. *Haml* - To write views in Haml

##Steps

- Generate a recipes controller (having title and description)
```sh
rails g controller recipes 
```

- Generate a Recipe model
```
rails g model Recipe title:string description:text user_id:integer
```

Then run the rake db:migrate command

- Setting up **recipe views**
 
recipes_controller.rb
```sh
before_action :find_recipe, only: [:edit,:update,:destroy,:show]
def index
	@recipes = Recipe.all
end
def new
	 @recipe = Recipe.new
end
def create
	@recipe = Recipe.new(recipe_params)
	if @recipe.save
		#success
	else
		render 'new'
	end
end

private
	def find_recipe
		@recipe = Recipe.find(params[:id])
	end
```

- Setting up **new forms** using simple_forms and haml

new.html.haml
```sh
- simple_form_for @recipe, html: {multipart: true} do |f|
	= f.input :title,input_html: {class: 'form-control'}
	= f.input :description,input_html: {class: 'form-control'}
	= f.input :image,input_html: {class: 'form-control'}
	= f.button :submit,input_html: {class: "btn btn-default"}
```
Thus using simple_form_for helper a field and label can be rendered using a single line of code.

_error_messages.html.haml
```sh
- if @recipe.errors.any?
		#errors
			%p
				=@recipe.errors.count
				prevented this form from saving
			%ul
				- if @recipe.errors.full_messages.each do |msg|
					%li= msg
```
