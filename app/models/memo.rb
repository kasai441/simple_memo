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

  class << self
    def all
      read_file.map do |id, memo|
        Memo.new(id, memo['title'], memo['content'])
      end
    end

    def find(id)
      return unless (data = read_file[id])

      Memo.new(id, data['title'], data['content'])
    end

    def add(params)
      id = Time.now.to_i.to_s
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
      if File.exist?(SAVE_FILE)
        File.open(SAVE_FILE, 'r') do |f|
          JSON.parse(f.read)
        end
      else
        {}
      end
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
end
