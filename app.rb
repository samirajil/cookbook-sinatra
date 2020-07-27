require "sinatra"
require "sinatra/reloader" if development?
require "byebug"
require "better_errors"
require_relative "cookbook"
require_relative "recipe"
set :bind, '0.0.0.0'

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

get '/recipes' do
  COOKBOOK = Cookbook.new('recipes.csv')
  @recipes = COOKBOOK.all
  erb :index
end

get '/create' do
  erb :create
end

get '/delete/:recipe_index' do
  index = params[:recipe_index]
  COOKBOOK.remove_recipe(index.to_i)
  erb :delete
end

post '/new' do
  time_to_cook = "#{params["time_to_cook"].to_i / 60} hours and #{params["time_to_cook"].to_i % 60} minutes"
  recipe = Recipe.new(params["name"], params["description"], time_to_cook, "false", params["difficulty"])
  COOKBOOK.add_recipe(recipe)
end
