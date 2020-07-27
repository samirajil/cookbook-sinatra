require 'csv'
require_relative 'recipe'
require_relative 'scrapingbbcfood'
require 'byebug'

class Cookbook
  def initialize(csv_file)
    @recipes = []
    @csv_file = csv_file
    csv_options = { col_sep: ',', quote_char: '"' }
    CSV.foreach(@csv_file, csv_options) do |row|
      @recipes << Recipe.new(row[0], row[1], row[2], row[3], row[4])
    end
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    save_recipes
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    save_recipes
  end

  def mark_as_done(recipe_index)
    @recipes[recipe_index].mark_as_done
    save_recipes
  end

  def parse_recipes(ingredient)
    ScrapeBbcGoodFoodService.call(ingredient)
  end

  def save_recipes
    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
    CSV.open(@csv_file, 'wb', csv_options) do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.time_to_cook, recipe.done, recipe.difficulty]
      end
    end
  end
end
