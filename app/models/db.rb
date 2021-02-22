# frozen_string_literal: true

require 'pg'
require 'yaml'

class SQL
  def initialize
    settings_file = 'database.yml'
    conn_settings = open(settings_file, 'r') { |f| YAML.load(f) }
    @conn = PG::Connection.new(conn_settings['default'])
    create_table = 'CREATE TABLE IF NOT EXISTS memos (
      id varchar(17),
      title varchar(100),
      content varchar(3000)
    )'
    @conn.exec(create_table)
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

  def insert(id, params)
    stmt = 'INSERT INTO memos (id, title, content) VALUES($1, $2, $3)'
    @conn.prepare('insert', stmt)
    @conn.exec_prepared('insert', [id, params[:title], params[:content]])
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