require 'mechanize'
require 'csv'
require 'pp'

class SQ_LAFORET
  def item_name_picker
    target_urls = ["", "Ka", "Sa", "Ta", "Na", "Ha", "Ma", "Ya"]
    base_url = "http://www.laforet.ne.jp/shop_search/brand"

    array = []
    agent = Mechanize.new
    target_urls.each do |target|
      source = agent.get(base_url + target)
      source.search('div.ResultUnitBrand').each do |e|
        e.search('dl').each do |d|
          array << d.search('dt').text
          #pp d.search('dd').search('a').text
          #array << remove_lf_code(d.text)
        end
      end
    end
    csv_saver(array)
  end

  def remove_lf_code(content)
    return content.gsub(/(\r\n|\r|\n)/, "")
  end

  def csv_saver(content)
    CSV.open('./csv/keyword_laforet.csv', 'wb') do |element|
      element << content
    end
  end
end

sq_laforet = SQ_LAFORET.new
sq_laforet.item_name_picker
