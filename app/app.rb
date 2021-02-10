require 'sinatra'
require 'sinatra/reloader'

get '/' do
  save_file = 'memo.json'
  if File.exist?(save_file)
    File.open(save_file, 'r') do |file|
      hash = JSON.load(file)
      return if hash.nil? || hash.size.zero?
      @memo = hash
      #hash.each_value do |v|
      #  @memo_title = v[:memo_title]
      #  @memo_content = v[:memo_content]
      #end
#      binding.irb
    end
  end
  erb :index
end

get '/hello' do  
  File.open('sample.txt', 'w') do |f|
    f.puts('Hello, World!')
  end
  redirect '/'
end

get '/read' do
  File.open('sample.txt', 'r') do |f|
    f.read
  end
end

get '/new' do
  erb :new
end

post '/new' do
  save_file = 'memo.json'
  hash = {}
  if File.exist?(save_file)
    hash = File.open(save_file, 'r') do |file|
      hash = JSON.load(file)
      hash ||= {}
    end
  end
    
  File.open(save_file, 'w') do |file|
    # binding.irb
    id = Time.now.strftime('%Y%m%d%H%M%S%L')
    hash[id] = { memo_title: params[:memo_title], memo_content: params[:memo_content] }
    str = JSON.dump(hash, file)
  end
end
