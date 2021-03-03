# frozen_string_literal: true

require_relative './db'

class Memo
  attr_accessor :id, :title, :content

  def initialize(id = 0, title = '', content = '')
    @id = id
    @title = title
    @content = content
  end

  class << self
    def all
      SQL.new.select_all.map do |memo|
        Memo.new(memo['id'], memo['title'], memo['content'])
      end
    end

    def find(id)
      memo = SQL.new.select(id)[0]
      Memo.new(memo['id'], memo['title'], memo['content'])
    end

    def add(params)
      SQL.new.insert(params)
    end

    def update(params)
      SQL.new.update(params[:id], params)
    end

    def destroy(id)
      SQL.new.delete(id)
    end
  end
end
