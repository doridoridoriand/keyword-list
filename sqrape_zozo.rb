require 'mechanize'
require 'csv'
require 'pp'

class SQ_ZOZO
  def item_name_picker
    array = []
    agent = Mechanize.new
    source = agent.get('http://zozo.jp/keyword/')
    source.search('div.text').each do |e|
      e.search('a').each do |n|
        array << n.text
      end
    end
    csv_saver(array.uniq)
  end

  def csv_saver(content)
    CSV.open('keyword_zozo.csv', 'wb') do |element|
      element << content
    end
  end
end

sq_zozo = SQ_ZOZO.new
sq_zozo.item_name_picker
