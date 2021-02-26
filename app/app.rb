# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'

require_relative './models/memo'
require_relative './helpers/helpers'

enable :method_override

get '/' do
  @memos = Memo.all
  erb :index
end

get '/show/:id' do
  @memo = Memo.find(params[:id])
  if @memo
    erb :show
  else
    'errors/404'
  end
end

get '/new' do
  erb :new
end

post '/new' do
  Memo.add(escape_params(params))
  redirect '/'
end

get '/edit/:id' do
  @memo = Memo.find(params[:id])
  if @memo
    erb :edit
  else
    'errors/404'
  end
end

patch '/edit/:id' do
  Memo.update(escape_params(params))
  redirect "/show/#{params[:id]}"
end

delete '/delete/:id' do
  Memo.destroy(params[:id])
  redirect '/'
end

private

def escape_params(params)
  [:title, :content].each { |e| params[e] = h(params[e]) }
  params
end
