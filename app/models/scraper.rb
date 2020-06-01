class Scraper

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
      end
    end
    return sales
 end
end



