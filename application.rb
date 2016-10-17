class Application < ApplicationBase
  def initialize(url, file_name)
    @doc = save_page(url)
    @links_category = []
    @file_name = file_name
  end

  def start
    getting_links
    save_csv
  end

  private

  def save_csv
    CSV.open("#{@file_name}.csv", 'wb') do |csv|
      @links_category.each do |link_category|
        extr = ExtractionProducts.new('https://www.viovet.co.uk' + 
                                      link_category)
        extr.extract
        extr.products.each do |product|
          csv << product.attributes
        end
      end
    end
  end

  def getting_links
    @doc.xpath(".//ul[@class='families-list']/li/a/@href").each do |link|
      @links_category << link
    end
  end
end
