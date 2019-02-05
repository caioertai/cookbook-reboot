require 'csv'
require_relative 'recipe'

class Cookbook
  def initialize(csv_path)
    @recipes  = []
    @csv_path = csv_path
    load_csv
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    update_csv
  end

  def remove_recipe(index)
    @recipes.delete_at(index)
    update_csv
  end

  def mark_as_done(index)
    @recipes[index].done!
    update_csv
  end

  private

  def load_csv
    # We used those options on the CSV class to allow its iterations to
    # return us something that behaves as a Hash
    # Check the CSV doc for more info:
    # https://ruby-doc.org/stdlib-2.5.3/libdoc/csv/rdoc/CSV.html#method-i-headers
    # https://ruby-doc.org/stdlib-2.5.3/libdoc/csv/rdoc/CSV.html#method-i-header_converters
    options = { headers: :first_row, header_converters: :symbol }
    # Notice that we're passing the options above along with the csv_path now
    CSV.foreach(@csv_path, options) do |recipe_attributes|
      # Because of our options above, the objects of our iterations look like
      # this now:
      # recipe_attributes => {
      #   name: 'Recipe name',
      #   description: 'Recipe description',
      #   prep_time: 'Xmin',
      #   done: 'false/true',
      # }
      # This allows as to just them exactly as they are to Recipe#initialize
      # by using (Recipe#new)
      # Check 'recipe.rb' to see how we handled the fact that the done
      # attribute is being saved as a string
      @recipes << Recipe.new(recipe_attributes)
    end
  end

  def update_csv
    CSV.open(@csv_path, 'wb') do |csv_file|
      # We're leaving the Recipe class to handle it's own headers. This, along
      # with the changes bellow allows as to remodel Recipe without changing
      # the Cookbook again
      csv_file << Recipe.attributes
      @recipes.each do |recipe|
        # We implemented a #to_a on Recipe, to allow as to remodel it without
        # having to ever change the Cookbook again
        csv_file << recipe.to_a
      end
    end
  end
end