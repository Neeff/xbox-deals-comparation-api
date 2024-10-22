#scraper pages and proccess data
require 'open-uri'
class Scraper

def self.scraper_page(browser, stores)
    offers = []
    stores.each do |store|
      browser.goto(store[:url])
      game = browser.div(class: 'gameDiv').wait_until(timeout: 200, &:present?)
      next_btn = browser.link(text: store[:text])
      one_page = game.present? && !next_btn.present?
      if one_page
        browser.div(class: 'gameDiv').wait_until(timeout: 200, &:present?)
        browser.divs(class: 'gameDiv').each {|item| offers << item.outer_html }
      else
        while next_btn.present? do
          browser.div(class: 'gameDiv').wait_until(timeout: 200, &:present?)
          browser.divs(class: 'gameDiv').each { |item | offers << item.outer_html }
          next_btn.click!
        end
       browser.div(class: 'gameDiv').wait_until(timeout: 200, &:present?)
       browser.divs(class: 'gameDiv').each { |item| offers << item.outer_html }
        end
    end
    offers
  end


  def self.scraper_page_game(url)
  end
def self.proccess_data(raw_data)
    #set logic for proccess raw_data that return scraper_page method of class
    offers = []
    raw_data.count.times do |i|
      doc = Nokogiri::HTML(raw_data[i])
      img = "https:" << doc.at_css('.c-image').attr('src')
      name = doc.at_css('h3').text
      status = doc.at_css('span').text
      link = doc.at_css('a').attr('href')
      currency = doc.at_css("meta[@itemprop='priceCurrency']").attr('content')
      old_price = doc.at_css('s').nil? ? doc.at_css("span[@itemprop='price']").text : doc.at_css('s').text
      new_price = doc.at_css("span[@itemprop='price']").text
      bi_product = doc.at_css("div.m-product-placement-item").attr('data-bigid')
      rating = doc.at_css("div.m-product-placement-item").attr('data-rating')
      if currency == 'CLP'
        old_price = old_price.split("$")[1].gsub(/[.,[:space:]]/, '')
        new_price = new_price.gsub(/[$,.[:space:]]/, '')
      else
        old_price = old_price.split("$")[1].gsub(/[$,[:space:]]/, '$'=> '', ','=> '.', ' '=> '')
        new_price = new_price.gsub(/[$,[:space:]]/, '$'=> '', ','=> '.', ' '=> '')
      end
      discount = (BigDecimal(old_price) - BigDecimal(new_price)) / BigDecimal(old_price) * BigDecimal(100)
      x = {status: status,
           name_game: name,
           link_to_xbox_site: link,
           img: img, currency: currency,
           old_price: old_price,
           new_price: new_price,
           discount: discount,
           data_bi_product: bi_product,
           rating: rating
      }
      offers << x
    end
    offers
   end
end



