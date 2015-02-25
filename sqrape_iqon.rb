require 'mechanize'
require 'csv'
require 'pp'

class SQ_IQON
  def item_name_picker
    array = []
    agent = Mechanize.new
    source = agent.get('http://www.iqon.jp/sets/search/item/')
    source.search('div.layout-column2-main').each do |item_name|
      item_name.search('a.search-tag').each do |name|
        array << name.text
      end
    end
    csv_saver(array)
  end

  def csv_saver(content)
    CSV.open('./csv/keyword_iqon.csv', 'wb') do |stream|
      stream << content
    end
  end
end

sq_iqon = SQ_IQON.new
sq_iqon.item_name_picker
