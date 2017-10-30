require_relative 'view'
require_relative 'recipe'
require_relative 'scrape_lets_cook_french_service'

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    recipes = @cookbook.all
    @view.display_recipes(recipes)
  end

  def create
    recipe_name = @view.ask_user_recipe_content("name")
    recipe_description = @view.ask_user_recipe_content("description")
    recipe_cooking_time = @view.ask_user_recipe_content("cooking time")
    attributes = { name: recipe_name, description: recipe_description, cooking_time: recipe_cooking_time, tested: false }
    recipe = Recipe.new(attributes)
    @cookbook.add_recipe(recipe)
  end

  def destroy
    list
    index = @view.ask_user_for_index("destroy")
    @cookbook.remove_recipe(index)
  end

  # Used to import recipes from the Letscookfrench website
  def import
    # Ask the user the ingredient that he/she wants
    ingredient = @view.ask_user_for_ingredient

    message = "'#{ingredient}' recipes"
    @view.show_scraping_message("Looking for", message)

    # Scraping the data
    scraper = ScrapeLetsCookFrenchService.new(ingredient)
    data_recipes = scraper.call

    @view.show_recipes_found(data_recipes)

    # Ask the user the recipe to import
    index_recipe = @view.ask_user_for_index("import")

    # creating the recipe and adding it to the database
    recipe = data_recipes[index_recipe]

    message = "'#{recipe.name}'"

    @view.show_scraping_message("Importing", message)

    # recipe = Recipe.new(attributes)
    @cookbook.add_recipe(recipe)
  end

  def mark_as_tested
    # list all recipes
    list

    # Ask user which recipe to mark as tested
    index_recipe = @view.ask_user_for_index("mark as tested")

    # In the cookbook as the recipe as tested
    @cookbook.mark_recipe_as_tested(index_recipe)

    # list all recipes
    list

    # store the data in the csv
    @cookbook.store_recipes_csv
  end
end
