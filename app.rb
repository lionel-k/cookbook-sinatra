require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"

require_relative 'lib/cookbook'
require_relative 'lib/controller'

csv_file   = File.join(__dir__, 'lib/recipes.csv')
cookbook   = Cookbook.new(csv_file)
controller = Controller.new(@cookbook)

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

get '/' do
  erb :index
end

get '/all' do
  @recipes = cookbook.all
  erb :all
end


