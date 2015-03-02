require 'mechanize'
require 'csv'
require 'pp'

class SQ_LUMINE
  def item_name_picker
    array = []
    agent = Mechanize.new
    source = agent.get('https://i.lumine.jp/shops')
    source.search('div.shopListMod02').each do |element|
      element.search('div.item').search('p').each do |ele|
        array << ele.search('span').search('a').text
      end
    end
    csv_saver(array.compact.uniq)
  end

  def csv_saver(content)
    CSV.open('./csv/keyword_ilumine.csv', 'wb') do |ele|
      ele << content
    end
  end
end

sq_lumine = SQ_LUMINE.new
sq_lumine.item_name_picker
