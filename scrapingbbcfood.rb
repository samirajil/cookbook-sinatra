class ScrapeBbcGoodFoodService # or ScrapeMarmitonService
  def initialize
    @ingredient = ingredient
  end

  def self.call(ingredient)
    url = "https://www.bbcgoodfood.com/search/recipes?query=#{ingredient}"
    doc = Nokogiri::HTML(open(url), nil, 'utf-8')
    recipes = []
    doc.search(".node-teaser-item").each do |element|
      title = element.search(".teaser-item__title").text.strip
      description = element.search(".field-item").text.strip
      hours = element.search(".hours").text.strip
      minutes = element.search(".mins").text.strip
      difficulty = element.search(".teaser-item__info-item--skill-level").text.strip
      recipe = [title, description, "#{hours == '' ? '0 hours' : hours} and #{minutes == '' ? '0 hours' : minutes}", false, difficulty]
      recipes << recipe
    end
    return recipes
  end
end