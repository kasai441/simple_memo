require 'sinatra'
require 'sinatra/reloader'

require_relative './models/memo'

enable :method_override

get '/' do
  @memo = Memo.all
  erb :index
end

get '/new' do
  erb :new
end

post '/new' do
  Memo.new(params)
end

get '/edit/:id' do
  file_hash = Memo.all
  @id = params[:id]
  @title = file_hash[params[:id]]['title']
  @content = file_hash[params[:id]]['content']
  erb :edit
end

patch '/edit/:id' do
  Memo.update(params)
end
