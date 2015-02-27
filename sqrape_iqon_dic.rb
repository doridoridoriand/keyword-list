require 'mechanize'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'pp'

class SQ_IQON_DIC
  def get_dic_page
    array = []
    temp = []
    description_arr = []
    gen_attack_url.each do |target|
      begin
        agent = Mechanize.new
        source = agent.get(target)
        description = source.search('div.word_definition').search('p').text
        temp << source.title.gsub(/\//, "")
        temp << description
        description_arr << temp.pop(2)
        array << source.title.gsub(/\//, "")
      rescue Mechanize::ResponseCodeError => e
        case e
        when "404"
          next
        end
      end
    end
    gen_csv('./temp/temp_iqon.csv', array)
    gen_csv('./temp/temp_iqon_des.csv', description_arr)
  end

  def gen_attack_url
    array = []
    baseurl = 'http://www.iqon.jp/dictionary/'
    for i in 1..300 do
      array << baseurl + i.to_s
    end
    return array
  end

  def description_title_modification
    load_temp_csv('./temp/temp_iqon_des.csv').each do |element|
      pp element.gsub(/"/, "")
    end
  end

  def name_picker
    array = []
    load_temp_csv('./temp/temp_iqon.csv').each do |n|
      n.slice!("とは - ファッション辞書 | iQON-レディースファッションアプリ")
      array << n
    end
    gen_csv('./csv/keyword_iqon_dic.csv', array)
  end

  def load_temp_csv(target_csv)
    return CSV.read(target_csv).flatten
  end

  def gen_csv(save_dir_name, content)
    CSV.open(save_dir_name, 'wb') do |element|
      element << content
    end
  end
end

sq_iqon_dic = SQ_IQON_DIC.new
#sq_iqon_dic.get_dic_page
#sq_iqon_dic.name_picker
sq_iqon_dic.description_title_modification
