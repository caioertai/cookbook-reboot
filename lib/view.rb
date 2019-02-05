class View
  def display(recipes)
    recipes.each_with_index do |recipe, index|
      x = recipe.done? ? 'x' : ' '
      puts "#{index + 1}. [#{x}] #{recipe.name} (#{recipe.prep_time}): #{recipe.description}"
      puts "----------"
    end
  end

  def ask_for_string(input)
    puts "What's the recipe #{input}?"
    gets.chomp
  end

  def ask_for_index
    puts "Which recipe (by number)?"
    gets.chomp.to_i - 1
  end
end
