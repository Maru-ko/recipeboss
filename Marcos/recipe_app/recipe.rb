require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra/content_for'
require 'tilt/erubis'
require 'redcarpet'
require 'yaml'
require 'bcrypt'

get "/" do
  #{}"<html><body><h1>Welcome to Recipe World</h1></body></html>"
  erb :index, layout: :layout
end