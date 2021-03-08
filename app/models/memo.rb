# frozen_string_literal: true

require 'pg'
require 'yaml'

class Memo
  attr_reader :id, :title, :content

  FILE_NAME = 'database.yml'
  SETTINGS_FILE = "#{File.dirname(__FILE__)}/#{FILE_NAME}"

  def initialize(id = 0, title = '', content = '')
    @id = id
    @title = title
    @content = content
  end

  class << self
    def all
      conn = connect_db
      stmt = 'SELECT * FROM memos'
      conn.exec(stmt).map do |memo|
        Memo.new(memo['id'], memo['title'], memo['content'])
      end
    end

    def find(id)
      conn = connect_db
      stmt = 'SELECT * FROM memos WHERE id = $1'
      conn.prepare('select', stmt)
      memo = conn.exec_prepared('select', [id])[0]
      Memo.new(memo['id'], memo['title'], memo['content'])
    end

    def add(params)
      conn = connect_db
      stmt = 'INSERT INTO memos (title, content) VALUES($1, $2)'
      conn.prepare('insert', stmt)
      conn.exec_prepared('insert', [params[:title], params[:content]])
    end

    def update(params)
      conn = connect_db
      stmt = 'UPDATE memos SET title = $2, content = $3 WHERE id = $1'
      conn.prepare('update', stmt)
      conn.exec_prepared('update', [params[:id], params[:title], params[:content]])
    end

    def destroy(id)
      conn = connect_db
      stmt = 'DELETE FROM memos WHERE id = $1'
      conn.prepare('delete', stmt)
      conn.exec_prepared('delete', [id])
    end

    private

    def connect_db
      conn_settings = File.open(SETTINGS_FILE, 'r') { |f| YAML.safe_load(f) }
      PG::Connection.new(conn_settings['default'])
    end
  end
end
