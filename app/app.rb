require 'sinatra'
require 'sinatra/reloader'

enable :method_override
SAVE_FILE = './memo.json'
get '/' do
  @memo = read_file(SAVE_FILE)
  erb :index
end

get '/new' do
  erb :new
end

post '/new' do
  file_hash = read_file(SAVE_FILE)
  id = Time.now.strftime('%Y%m%d%H%M%S%L')
  write_file(SAVE_FILE, file_hash, id)
end

get '/edit/:id' do
  file_hash = read_file(SAVE_FILE)
  @id = params[:id]
  @memo_title = file_hash[params[:id]]['memo_title']
  @memo_content = file_hash[params[:id]]['memo_content']
  erb :edit
end

patch '/edit/:id' do
  file_hash = read_file(SAVE_FILE) 
  id = params[:id]
  write_file(SAVE_FILE, file_hash, id)
end

private

def read_file(file)
  file_hash = {}
  if File.exist?(file)
    File.open(file, 'r') do |f|
      file_hash = JSON.load(f)
    end
  end
  file_hash ||= {}
end

def write_file(file, file_hash, id)
  File.open(file, 'w') do |f|
    file_hash[id] = { memo_title: params[:memo_title], memo_content: params[:memo_content] }
    str = JSON.dump(file_hash, f)
  end
end
