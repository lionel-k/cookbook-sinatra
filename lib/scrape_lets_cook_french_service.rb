# require 'nokogiri'
# require 'open-uri'
require_relative 'recipe'


class ScrapeLetsCookFrenchService
  def initialize(keyword)
    @keyword = keyword
  end

  def call
    # file = 'tomato.html'  # or 'strawberry.html'
    # html_doc = Nokogiri::HTML(File.open(file), nil, 'utf-8')
    url = "http://www.letscookfrench.com/recipes/find-recipe.aspx?s=#{@keyword}"
    html_doc = Nokogiri::HTML(open(url), nil, 'utf-8')

    recipes = get_recipes(html_doc)
    return recipes
  end

  private

  def get_cooking_time(html_element)
    time = html_element.search('.m_detail_time').text
    time.gsub!(/min/,"")
    time_a = time.split(" ").reject { |t| t.to_i <= 0 }
    cooking_time = time_a.inject(0){ |sum, x| sum + x.to_i }
    return cooking_time
  end

  def get_ingredients(html_element)
    html_element.search('.m_texte_resultat').text.strip.split(".").first.gsub("Ingredients : ", "")
  end

  def get_recipes(html_doc)
    result = []
    html_doc.search('.m_contenu_resultat').each do |element|
      recipe_name = element.search('.m_titre_resultat a').text
      recipe_description = element.search('.m_detail_recette').text.strip
      cooking_time = get_cooking_time(element)
      recipe_ingredients = get_ingredients(element)
      attributes = { name: recipe_name, description: recipe_description, cooking_time: cooking_time, ingredients: recipe_ingredients}
      result << Recipe.new(attributes)
    end
    result
  end
end
