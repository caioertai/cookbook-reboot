require_relative 'view'
require_relative 'scrape_service'

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    display_recipes
  end

  def create
    name = @view.ask_for_string('name')
    description = @view.ask_for_string('description')
    prep_time = @view.ask_for_string('preparation time')
    recipe = Recipe.new(name: name, description: description, prep_time: prep_time)
    @cookbook.add_recipe(recipe)
  end

  def destroy
    display_recipes
    index = @view.ask_for_index
    @cookbook.remove_recipe(index)
  end

  def import
    # Ask the user for a query
    # Get the query
    query = @view.ask_for_string("ingredient you're looking for")
    # Ask ScrapeService for the array of recipes
    recipes = ScrapeService.new(query).call
    # Display the array
    @view.display(recipes)
    # Ask the user for one to add to the cookbook
    index = @view.ask_for_index
    # Add the recipe to the cook
    recipe = recipes[index]
    @cookbook.add_recipe(recipe)
  end

  def mark_recipe_as_done
    # Display the list
    display_recipes
    # Ask for the index to mark
    index = @view.ask_for_index
    # get the cookbook to mark the recipe
    @cookbook.mark_as_done(index)
  end

  private

  def display_recipes
    recipes = @cookbook.all
    @view.display(recipes)
  end
end