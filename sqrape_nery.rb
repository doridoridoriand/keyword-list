require 'mechanize'
require 'csv'
require 'pp'

class SQ_MERY
  def item_name_picker
    array = []
    agent = Mechanize.new
    target = ['http://mery.jp/tag/45/all', 'http://mery.jp/tag/48/all', 'http://mery.jp/tag/7964/all']
    target.each do |t|
      source = agent.get(t)
      source.search('ul.other_keyword_list').each do |element|
        element.search('a').each do |e|
          array << e.text
        end
      end
    end
    csv_saver(array.uniq)
  end

  def csv_saver(content)
    CSV.open('keyword_mery.csv', 'wb') do |e|
      e << content
    end
  end
end

sq_mery = SQ_MERY.new
sq_mery.item_name_picker
