require 'mechanize'
require 'csv'
require 'pp'

class SQ_MERCARI
  def get_source
    array = []
    item_array = []
    agent = Mechanize.new
    source = agent.get('http://www.mercariapp.com/jp/category/')

    #source.search("//")
    for i in 0..22 do
      item_array << source.search('ul.categories-index-list-sub-sub-categories')[i]
    end

    item_array.each do |element|
      element.search('li').search('a').each do |e|
        array << e.text
      end
    end
    csv_saver(array.uniq)
  end

  def csv_saver(content)
    CSV.open('./csv/keyword_mercari.csv', 'wb') do |data|
      data << content
    end
  end
end

sq_mercari = SQ_MERCARI.new
sq_mercari.get_source
