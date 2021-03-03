# frozen_string_literal: true

require 'pg'
require 'yaml'

class SQL
  FILE_NAME = 'database.yml'
  SETTING_FILE = "#{File.dirname(__FILE__)}/#{FILE_NAME}"
  def initialize
    conn_settings = File.open(SETTING_FILE, 'r') { |f| YAML.safe_load(f) }
    @conn = PG::Connection.new(conn_settings['default'])
  end

  def select_all
    stmt = 'SELECT * FROM memos'
    @conn.exec(stmt)
  end

  def select(id)
    stmt = 'SELECT * FROM memos WHERE id = $1'
    @conn.prepare('select', stmt)
    @conn.exec_prepared('select', [id])
  end

  def insert(params)
    stmt = 'INSERT INTO memos (title, content) VALUES($1, $2)'
    @conn.prepare('insert', stmt)
    @conn.exec_prepared('insert', [params[:title], params[:content]])
  end

  def update(id, params)
    stmt = 'UPDATE memos SET title = $2, content = $3 WHERE id = $1'
    @conn.prepare('update', stmt)
    @conn.exec_prepared('update', [id, params[:title], params[:content]])
  end

  def delete(id)
    stmt = 'DELETE FROM memos WHERE id = $1'
    @conn.prepare('delete', stmt)
    @conn.exec_prepared('delete', [id])
  end
end
