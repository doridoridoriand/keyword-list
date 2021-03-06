require 'csv'
require 'pp'

class MERGE_CSV
  def gen_master_csv
    arr = []
    modified = []
    load_csvs.each do |item_element|
      arr << item_element.split('/')
    end
    arr.flatten.compact.uniq.each do |element_name|
      modified << element_name.gsub(/"/, "")
    end
    csv_saver(modified)
  end

  def csv_saver(content)
    pp content.count
    CSV.open('master_csv.csv', 'wb') do |data|
      data << content
    end
  end

  def load_csvs
    array = []
    get_csv_list.each do |file|
      array << CSV.read(file)
    end
    return array.flatten.uniq.compact
  end

  def get_csv_list
    return Dir.glob("./csv/*")
  end
end

merge_csv = MERGE_CSV.new
merge_csv.gen_master_csv
