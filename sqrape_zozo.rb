require 'mechanize'
require 'csv'
require 'json'
require 'open-uri'
require 'pp'

class SQ_ZOZO
  # 結構時間かかる
  def chief_manager
    source1 = get_all_keywords
    source2 = parse_attract_keyword
    source3 = item_name_picker

    source1 << source2 << source3
    csv_saver(source1.flatten.compact)
  end

  def get_all_keywords
    array = []
    target_url = 'http://zozo.jp/keyword/'
    agent = Mechanize.new
    source = agent.get(target_url)
    source.search('ul.lists').search('a').each do |element|
      element.map { |target|
        array << target[1]
      }
    end
    attack_target_url(array)
  end

  def attack_target_url(attack_list)
    target_url_arr = []
    item_name_arr = []
    base_url = 'http://zozo.jp'
    attack_list.map { |target|
      target_url_arr << base_url + target
    }

    agent = Mechanize.new
    target_url_arr.each do |target_url|
      source = agent.get(target_url)
      source.search('ul.first').search('li').each do |element|
        item_name_arr << element.search('div.text').text
      end
    end
    return item_name_arr
  end

  def parse_attract_keyword
    array = []
    endpoint = 'http://zozo.jp/keyword/trendwordjson.txt'
    source = JSON.parse(open(endpoint).read)
    source.each do |element|
      array << element.values[3]
    end
    return array
  end

  def item_name_picker
    array = []
    agent = Mechanize.new
    source = agent.get('http://zozo.jp/keyword/')
    source.search('div.text').each do |e|
      e.search('a').each do |n|
        array << n.text
      end
    end
    return array
  end

  def csv_saver(content)
    CSV.open('./csv/keyword_zozo.csv', 'wb') do |element|
      element << content
    end
  end
end

sq_zozo = SQ_ZOZO.new
sq_zozo.chief_manager
