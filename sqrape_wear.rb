require 'open-uri'
require 'json'
require 'csv'
require 'pp'

class SQ_WEAR
  def item_name_picker
    keywords = []
    json_opener('https://wear.jp/common/json/pickup_tag.json').map { |element|
      keywords << element.values[0]
    }
    csv_saver(keywords)
  end

  def json_opener(target_url)
    return JSON.parse(open(target_url).read)
  end

  def csv_saver(content)
    CSV.open('./csv/keyword_wear.csv', 'wb') do |data|
      data << content
    end
  end
end

sq_wear = SQ_WEAR.new
sq_wear.item_name_picker
