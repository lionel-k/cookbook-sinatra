class Recipe
  attr_reader :name, :description, :cooking_time, :tested, :ingredients, :difficulty

  def initialize(attributes = {})
    @name = attributes[:name]
    @description = attributes[:description]
    @cooking_time = attributes[:cooking_time]
    @tested = attributes[:tested] || false
    @ingredients = attributes[:ingredients]
    @difficulty = attributes[:difficulty]
  end

  def tested!
    @tested = true
  end

  def is_tested?
    @tested
  end

end
