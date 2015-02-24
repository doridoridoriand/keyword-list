require 'mechanize'
require 'csv'
require 'pp'

class SQ_NAVER
  def item_name_picker
    array = []
    agent = Mechanize.new
    for i in 1..2 do
      source = agent.get('http://matome.naver.jp/keyword/girls?page=' << i)
      source.search('ul.mdKWList01Ul').each do |element|
        element.search('li').each do |e|
          array  << e.text
        end
      end
      csv_saver(array.uniq)
    end

  end

  def csv_saver(content)
    CSV.open('keyword_naver.csv', 'wb') do |element|
      element << content
    end
  end
end

sq_naver = SQ_NAVER.new
sq_naver.item_name_picker
