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

  private

  def load_csv
    CSV.foreach(@csv_path) do |row|
      @recipes << Recipe.new(row[0], row[1])
    end
  end

  def update_csv
    CSV.open(@csv_path, 'wb') do |csv_file|
      @recipes.each do |recipe|
        csv_file << [recipe.name, recipe.description]
      end
    end
  end
end