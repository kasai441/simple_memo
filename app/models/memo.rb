# frozen_string_literal: true

require_relative './db'

class Memo
  attr_accessor :id, :title, :content

  def initialize(id = '', title = '', content = '')
    @id = id
    @title = title
    @content = content
  end

  def all
    memos = []
    SQL.new.select_all.each do |memo|
      memos << Memo.new(memo['id'], memo['title'], memo['content'])
    end
    memos
  end

  def find(id)
    memo = SQL.new.select(id)[0]
    Memo.new(memo['id'], memo['title'], memo['content'])
  end

  def add(params)
    id = Time.now.strftime('%Y%m%d%H%M%S%L')
    SQL.new.insert(id, params)
  end

  def update(params)
    SQL.new.update(params[:id], params)
  end

  def destroy(id)
    SQL.new.delete(id)
  end
end
