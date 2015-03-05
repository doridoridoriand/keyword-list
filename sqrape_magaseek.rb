require 'mechanize'
require 'MeCab'
require 'csv'
require 'pp'

class SQ_MAGASEEK
  def get_source
    array = []
    agent = Mechanize.new
    source = agent.get('http://www.magaseek.com/rnk/pv/tp_1')
    source.search('p.item').each do |element|
      array << element.search('a').text.strip
    end
    #pp array
    mecab_processor(array)
  end

  def mecab_processor(content)
    array = []
    item_array = []
    mecab = MeCab::Tagger.new("-Ochasen")
    content.each do |content_element|
      data = mecab.parse(content_element).gsub!(/(\r\n|\r|\n)/, "")
      data.gsub!(/(\t)/, ",")
      pp data
      #pp mecab.parseToNode(content_element).feature.force_encoding('UTF-8')
    end
  end

  def csv_saver(content)
    CSV.open('./csv/keyword_magaseek.csv', 'wb') do |data|
      data << content
    end
  end
end
sq_magaseek = SQ_MAGASEEK.new
sq_magaseek.get_source
