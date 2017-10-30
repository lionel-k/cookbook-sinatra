require 'nokogiri'
file = 'strawberry.html'  # or 'strawberry.html'
html_doc = Nokogiri::HTML(File.open(file), nil, 'utf-8')

result = []

html_doc.search('.m_contenu_resultat').each do |element|
  recipe_name = element.search('.m_titre_resultat a').text
  recipe_description = element.search('.m_detail_recette').text.strip
  # p recipe_name
  # p recipe_description
  time = element.search('.m_detail_time').text
  time.gsub!(/min/,"")
  time_a = time.split(" ").reject { |t| t.to_i <= 0 }
  cooking_time = time_a.inject(0){ |sum, x| sum + x.to_i }
  # p cooking_time

  ingredients = element.search('.m_texte_resultat').text.strip.split(".").first.gsub("Ingredients : ", "")
  p ingredients

  result << {recipe_name: recipe_name, recipe_description: recipe_description, cooking_time: cooking_time}
end

# p result
