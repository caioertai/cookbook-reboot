class View
  def display(recipes)
    recipes.each_with_index do |recipe, index|
      puts "#{index + 1}. #{recipe.name}:"
      puts "   #{recipe.description}"
      puts "----------"
    end
  end

  def ask_for_string(input)
    # Display message
    puts "What's the recipe #{input}?"
    # get input
    gets.chomp
  end

  def ask_for_index
    # Print message
    puts "Which recipe (by number)?"
    # get input
    gets.chomp.to_i - 1
  end
end
