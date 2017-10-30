class View
  def display_recipes(recipes)
    recipes.each_with_index do |recipe, index|
      tested = recipe.is_tested? ? "[X]" : "[ ]"
      cooking_time = recipe.cooking_time == "" ? "" : "(#{recipe.cooking_time} min)"
      puts "#{'%2d' % (index + 1)} - #{tested} #{recipe.name} : #{recipe.description} #{cooking_time}"
      puts "\t> Ingredients: #{recipe.ingredients}" unless (recipe.ingredients == "" or recipe.ingredients.nil?)
    end
    puts " " * 30 + "-" * 20
  end

  def ask_user_recipe_content(content)
    puts "What is the #{content} of the recipe ?"
    print "> "
    gets.chomp
  end

  def ask_user_for_index(action)
    puts ""
    puts "Please type a number of which recipe to #{action}"
    print "> "
    gets.chomp.to_i - 1
  end

  def ask_user_for_ingredient
    puts "What ingredient would you like a recipe for?"
    print "> "
    gets.chomp
  end

  def show_scraping_message(action, content)
    puts ""
    puts "#{action} #{content} on LetsCookFrench..."
  end

  def show_recipes_found(data_recipes)
    puts "#{data_recipes.size} results found!"
    puts ""
    data_recipes.each_with_index do |recipe, index|
    puts "#{index + 1}. #{recipe.name}"
    end
  end
end
