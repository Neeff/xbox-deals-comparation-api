#scraper pages and proccess data
class Scraper

<<<<<<< HEAD
  def self.scraping_xbox_page(browser, url, text, region, currency)
    sales = []
    browser.goto(url)
    next_btn =  browser.link(text: text).wait_until(timeout: 300, &:present?)
    while next_btn.present? do
      browser.a(class: 'gameDivLink').wait_until(timeout: 200, &:present?)
      browser.links(class: 'gameDivLink').each do |item|
        x = {}
        x[:status]            = item.span.text
        x[:name_game]         = item.div.h3.text
        x[:link_to_xbox_site] = item.href
        x[:img]               = item.img.src
        x[:region]            = region
        x[:currency]          = currency
        prices                = []
        item.div(itemprop: 'offers').children.each do |i|
           prices << i.text if i.text != ''
=======
  def self.scraper_page(browser, stores)
    offers = []
    stores.each do |store|
      browser.goto(store[:url])
      game = browser.a(class: 'gameDivLink').wait_until(timeout: 200, &:present?)
      next_btn = browser.link(text: store[:text])
      one_page = game.present? && !next_btn.present?
      if one_page
        browser.a(class: 'gameDivLink').wait_until(timeout: 200, &:present?)
        browser.links(class: 'gameDivLink').each {|item| offers << item.outer_html }
      else
        while next_btn.present? do
          browser.a(class: 'gameDivLink').wait_until(timeout: 200, &:present?)
          browser.links(class: 'gameDivLink').each { |item | offers << item.outer_html }
          next_btn.click!
>>>>>>> optimize_code
        end
       browser.a(class: 'gameDivLink').wait_until(timeout: 200, &:present?)
       browser.links(class: 'gameDivLink').each { |item| offers << item.outer_html }
        end
<<<<<<< HEAD
        if x[:new_price] == ''
          x[:discount] = ((x[:old_price].to_f - x[:old_price].to_f)/x[:old_price].to_f * 100.to_f).to_s
        else
          x[:discount] = ((x[:old_price].to_f - x[:new_price].to_f)/x[:old_price].to_f * 100.to_f).to_s
        end
        sales << x
      end
     next_btn.click!
    end
    if !next_btn.present?
      browser.a(class: 'gameDivLink').wait_until(timeout: 200, &:present?)
      browser.links(class: 'gameDivLink').each do |item|
        x = {}
        x[:status]            = item.span.text
        x[:name_game]         = item.div.h3.text
        x[:link_to_xbox_site] = item.href
        x[:img]               = item.img.src
        x[:region]            = region
        x[:currency]          = currency
        prices = []
        item.div(itemprop: 'offers').children.each do |i|
           prices << i.text if i.text != ''
        end
        if(currency == 'CLP')
          x[:old_price] = prices[0].split("$")[1].to_s.gsub(/[.,[:space:]]/, '')
          x[:new_price] = prices[1].to_s.gsub(/[$,.[:space:]]/, '')
        else
          x[:old_price] = prices[0].split("$")[1].to_s.gsub(/[$,[:space:]]/, '$'=> '', ','=> '.', ' '=> '')
          x[:new_price] = prices[1].to_s.gsub(/[$,[:space:]]/, '$'=> '', ','=> '.', ' '=> '')
        end
        if x[:new_price] == ''
          x[:discount] = ((x[:old_price].to_f - x[:old_price].to_f)/x[:old_price].to_f * 100.to_f).to_s
        else
          x[:discount] = ((x[:old_price].to_f - x[:new_price].to_f)/x[:old_price].to_f * 100.to_f).to_s
        end
        sales << x
=======
    end
    offers
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
      if currency == 'CLP'
        old_price = old_price.split("$")[1].gsub(/[.,[:space:]]/, '')
        new_price = new_price.gsub(/[$,.[:space:]]/, '')
      else
        old_price = old_price.split("$")[1].gsub(/[$,[:space:]]/, '$'=> '', ','=> '.', ' '=> '')
        new_price = new_price.gsub(/[$,[:space:]]/, '$'=> '', ','=> '.', ' '=> '')
>>>>>>> optimize_code
      end
      discount = (BigDecimal(old_price) - BigDecimal(new_price)) / BigDecimal(old_price) * BigDecimal(100)
      x = {status: status, name_game: name, link_to_xbox_site: link, img: img, currency: currency, old_price: old_price, new_price: new_price, discount: discount }
      offers << x
    end
    offers
  end
end



