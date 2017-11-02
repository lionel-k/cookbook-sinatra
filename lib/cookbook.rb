require 'csv'

class Cookbook
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @csv_options = { col_sep: ',', force_quotes: true, quote_char: '"', headers: :first_row }
    @recipes = []
    load_recipes_csv
  end

  def add_recipe(recipe)
    @recipes << recipe
    store_recipes_csv
  end

  def remove_recipe(index)
    @recipes.delete_at(index)
    store_recipes_csv
  end

  def all
    @recipes
  end

  def mark_recipe_as_tested(index)
    @recipes[index].tested!
  end

  def save_to_csv
    store_recipes_csv
  end

  private

  def load_recipes_csv
    CSV.foreach(@csv_file_path, @csv_options) do |row|
      name = row["name"]
      description = row["description"]
      cooking_time = row["cooking_time"]
      tested = row["tested"] == 'true'
      ingredients = row["ingredients"]
      difficulty = row["difficulty"]
      attributes = { name: name, description: description, cooking_time: cooking_time, tested: tested, ingredients: ingredients, difficulty: difficulty }
      recipe = Recipe.new(attributes)
      @recipes << recipe
    end
  end

  def store_recipes_csv
    CSV.open(@csv_file_path, 'wb', @csv_options) do |csv|
      csv << ["name", "description", "cooking_time", "tested", "ingredients", "difficulty"]
      @recipes.each do |recipe|
        recipe_a = [recipe.name, recipe.description, recipe.cooking_time, recipe.tested, recipe.ingredients, recipe.difficulty]
        csv << recipe_a
      end
    end
  end
end
