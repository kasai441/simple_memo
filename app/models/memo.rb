# frozen_string_literal: true

class Memo
  FILE_NAME = 'memo.json'
  SAVE_FILE = "#{File.dirname(__FILE__)}/../public/data/#{FILE_NAME}"

  attr_accessor :id, :title, :content

  def initialize(id = '', title = '', content = '')
    @id = id
    @title = title
    @content = content
  end

  def all
    memos = []
    read_file.each do |id, memo|
      memos << Memo.new(id, memo['title'], memo['content'])
    end
    memos
  end

  def find(id)
    file_hash = read_file
    Memo.new(id, file_hash[id]['title'], file_hash[id]['content']) if file_hash[id]
  end

  def add(params)
    id = Time.now.strftime('%Y%m%d%H%M%S%L')
    write_id_params(id, params)
  end

  def update(params)
    write_id_params(params[:id], params)
  end

  def destroy(id)
    file_hash = read_file
    file_hash.delete(id)
    write_file(file_hash)
  end

  private

  def read_file
    file_hash = {}
    if File.exist?(SAVE_FILE)
      File.open(SAVE_FILE, 'r') do |f|
        file_hash = JSON.parse(f.read)
      end
    end
    file_hash ||= {}
  end

  def write_id_params(id, params)
    file_hash = read_file
    file_hash[id] = { title: params[:title], content: params[:content] }
    write_file(file_hash)
  end

  def write_file(file_hash)
    File.open(SAVE_FILE, 'w') do |f|
      JSON.dump(file_hash, f)
    end
  end
end
