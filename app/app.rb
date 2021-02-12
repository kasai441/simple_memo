require 'sinatra'
require 'sinatra/reloader'

require_relative './models/memo'

enable :method_override

get '/' do
  @memos = Memo.new.all
  erb :index
end

get '/show/:id' do
  @memo = Memo.new.find(params[:id])
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
  Memo.new.add(params)
  redirect '/'
end

get '/edit/:id' do
  @memo = Memo.new.find(params[:id])
  if @memo
    erb :edit
  else
    'errors/404'
  end
end

patch '/edit/:id' do
  Memo.new.update(params)
  redirect "/show/#{params['id']}"
end

delete '/delete/:id' do
  Memo.new.destroy(params[:id])
  redirect "/"
end
