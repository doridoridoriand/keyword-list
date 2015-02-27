require 'mechanize'
require 'csv'
require 'pp'

class SQ_FP
  def merge_both_data
    brand_source = brand_name_picker
    item_source = item_name_picker
    array = brand_source << item_source
    csv_saver(array.flatten)
  end

  def brand_name_picker
    array = []
    agent = Mechanize.new
    source = agent.get('http://www.fashion-press.net/brands/')
    source.search('//*[@id="brandlist"]/table').each do |data_element|
      data_element.search('tr').search('td').search('ul').each do |element|
        element.search('a').each do |item_name|
          array << item_name.text
        end
      end
    end
    return array.uniq
  end

  def item_name_picker
    array = []
    agent = Mechanize.new
    source = agent.get('http://www.fashion-press.net/words/')
    source.search('li.four-list').each do |element|
      array << element.search('a').text
    end
    return array.uniq
  end

  def csv_saver(content)
    CSV.open('./csv/keyword_fashion_press.csv', 'wb') do |data|
      data << content
    end
  end
end
sq_fp = SQ_FP.new
sq_fp.merge_both_data
