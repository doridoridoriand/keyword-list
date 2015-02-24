require 'mechanize'
require 'csv'
require 'pp'

class SQ_BUYMA
  def item_name_picker
    array = []
    agent = Mechanize.new
    source = agent.get('http://www.buyma.com/')
    source.search('li.level01').each do |element|
      array << element
    end
    csv_saver(array)
  end
  def csv_saver(content)
    CSV.open('keyword_buyma.csv', 'wb') do |element|
      element << content
    end
  end
end

sq_buyma = SQ_BUYMA.new
sq_buyma.item_name_picker
