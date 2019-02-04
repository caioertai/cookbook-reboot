require_relative 'view'

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    display_recipes
  end

  def create
    # Ask the view for a name
    name = @view.ask_for_string('name')
    # Ask the view for a description
    description = @view.ask_for_string('description')
    # Initialize a recipe
    recipe = Recipe.new(name, description)
    # Ask the repository (cookbook) to store the recipe
    @cookbook.add_recipe(recipe)
  end

  def destroy
    # Get the recipes array from the repo
    # Ask the view display the list]
    display_recipes
    # Ask the view for the index of the recipe
    index = @view.ask_for_index
    # Ask the repo (cookbook) to delete the recipe
    @cookbook.remove_recipe(index)
  end

  private

  def display_recipes
    # Get the recipes array from the repo
    recipes = @cookbook.all
    # Ask the view to display them
    @view.display(recipes)
  end
end