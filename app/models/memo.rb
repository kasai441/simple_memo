class Memo
  SAVE_FILE = './memo.json'
  
  def self.all
    read_file
  end

  def self.new(params)
    id = Time.now.strftime('%Y%m%d%H%M%S%L')
    write_file(id, params)
  end

  def self.update(params)
    write_file(params[:id], params)
  end

  private
 
  def self.read_file
    file_hash = {}
    if File.exist?(SAVE_FILE)
      File.open(SAVE_FILE, 'r') do |f|
        file_hash = JSON.load(f)
      end
    end
    file_hash ||= {}
  end
  
  def self.write_file(id, params)
    file_hash = read_file
    File.open(SAVE_FILE, 'w') do |f|
      file_hash[id] = { title: params[:title], content: params[:content] }
      str = JSON.dump(file_hash, f)
    end
  end
end
