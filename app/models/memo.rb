class Memo
  SAVE_FILE = './memo.json'
  
  def self.all
    read_file(SAVE_FILE)
  end

  def self.new(params)
    file_hash = read_file(SAVE_FILE)
    id = Time.now.strftime('%Y%m%d%H%M%S%L')
    write_file(SAVE_FILE, file_hash, id, params)
  end

  def self.update(params)
    file_hash = read_file(SAVE_FILE)
    id = params[:id]
    write_file(SAVE_FILE, file_hash, id, params)
  end

  private
 
  def self.read_file(file)
    file_hash = {}
    if File.exist?(file)
      File.open(file, 'r') do |f|
        file_hash = JSON.load(f)
      end
    end
    file_hash ||= {}
  end
  
  def self.write_file(file, file_hash, id, params)
    File.open(file, 'w') do |f|
      file_hash[id] = { title: params[:title], content: params[:content] }
      str = JSON.dump(file_hash, f)
    end
  end
end
