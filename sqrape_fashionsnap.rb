require 'mechanize'
require 'csv'
require 'pp'

class SQ_FS
  def brand_name_picker
    array = []
    agent = Mechanize.new
    source = agent.get('http://www.fashionsnap.com/dictionary/')
    source.search('ol#box').each do |element|
      array << element.text.strip.gsub(/\n/, ",")
    end
    csv_saver(array.flatten)
  end

  def csv_saver(content)
    CSV.open('./csv/keyword_fashionsnap.csv', 'wb') do |element|
      element << content
    end
  end
end

sq_fs = SQ_FS.new
sq_fs.brand_name_picker
