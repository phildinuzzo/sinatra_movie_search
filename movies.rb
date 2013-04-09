require 'pry'
gem 'sinatra', '1.3.0'
require 'sinatra'
require 'sinatra/reloader'
require 'open-uri'
require 'json'
require 'uri'
require 'better_errors'
configure :development do
use BetterErrors::Middleware
BetterErrors.application_root = File.expand_path("..", __FILE__)
end

#API !~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
get '/home/search' do
  @query = params[:query]
  file = open("http://www.omdbapi.com/?s=#{URI.escape(@query)}")
  @results = JSON.load(file.read)
erb :search_results
end

get '/home/detail/:imdb' do
  @imdb = params[:imdb]
  file = open("http://www.omdbapi.com/?i=#{URI.escape(@imdb)}")
  @results = JSON.load(file.read)
erb :movie_details
end

get '/home' do
  erb :home
end

get '/' do
  redirect '/home'
end


