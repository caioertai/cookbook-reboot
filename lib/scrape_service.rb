require 'open-uri'
require 'nokogiri'

require_relative 'recipe'

class ScrapeService
  def initialize(query)
    @query = query
  end

  def call
    # Use the query on the base url of Let's CookFrench
    query_url = "http://www.letscookfrench.com/recipes/find-recipe.aspx?aqt=#{@query}"
    # Open the page and read it
    page_string = open(query_url).read
    # Parse it using Nokogiri
    doc = Nokogiri::HTML(page_string)
    # Search for the recipe cards in the page and limit to 5
    recipe_cards = doc.search('.m_contenu_resultat').first(5)
    # Create and array to receive instances of recipes
    recipes = []
    # Look for the name and description in EACH card
    recipe_cards.each do |recipe_card|
      # Abstracted building the attributes for Recipe#new into a
      # different method
      attributes = recipe_attributes(recipe_card)
      # Use the attributes returned by #recipe_attributes to insert a new
      # instance of a recipe into the recipes array
      recipes << Recipe.new(attributes)
    end
    # We need to return the array that we built in the iteration (the
    # controller expects this)
    recipes
  end

  ##
  # This method will return the attributes for a recipe instance by looking
  # through the Nokogiri element saved on recipe_card
  def recipe_attributes(element)
    {
      name: element.at('.m_titre_resultat').text.strip,
      description: element.at('.m_texte_resultat').text.strip,
      # To understand the weird #&. marks, read this:
      # http://mitrev.net/ruby/2015/11/13/the-operator-in-ruby/
      # It's an interesting feature that avoids broken code from chaining
      # methods into nil. In this case, not every page has elements with
      # .m_detail_time, so we're avoiding calling the next methods on nil.
      prep_time: element.at('.m_detail_time')&.first_element_child&.text&.strip
    }
  end
end
