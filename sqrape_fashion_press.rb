require 'mechanize'
require 'csv'
require 'pp'

class SQ_FP
  def item_name_pcker
    array = []
    agent = Mechanize.new
    source = agent.get('http://www.fashion-press.net/words/')
    source.search('li.four-list').each do |element|
      array << element.search('a').text
    end
    csv_saver(array.uniq)
  end

  def csv_saver(content)
    CSV.open('./csv/keyword_fashion_press.csv', 'wb') do |e|
      e << content
    end
  end
end
sq_fp = SQ_FP.new
sq_fp.item_name_pcker
