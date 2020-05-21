class Scraper 

  def scraping_xbox_page(url, text,region,currency)
    sales = []
    browser  = Watir::Browser.new :chrome, args: %w[--headless --no-sandbox --disable-dev-shm-usage --disable-gpu --remote-debugging-port=9222]
    browser.goto(url)
    next_btn =  browser.link(text: text).wait_until(timeout: 60 ,&:present?)
    puts "next button is hidden?", next_btn.present?
    while next_btn.present? do
      browser.a(class: 'gameDivLink').wait_until(timeout: 200, &:present?) 
      data = browser.links(class: 'gameDivLink').to_a
      data.each do |item|
        x = {}
        x[:status]    =  item.span.text
        x[:name_game] = item.div.h3.text
        x[:link_to_xbox_site] = item.href
        x[:img] = item.img.src
        x[:region] = region
        x[:currency] = currency
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
          discount = (x[:old_price].to_f - x[:old_price].to_f)/x[:old_price].to_f * 100.to_f
          x[:discount] = discount.to_s
        else
          discount = (x[:old_price].to_f - x[:new_price].to_f)/x[:old_price].to_f * 100.to_f
        x[:discount] = discount.to_s
        end
        sales << x 
      end
     next_btn.click!
    
    end
    if !next_btn.present? 
      browser.a(class: 'gameDivLink').wait_until(timeout: 200, &:present?) 
      data = browser.links(class: 'gameDivLink').to_a
      data.each do |item|
        x = {}
        x[:status]    =  item.span.text
        x[:name_game] = item.div.h3.text
        x[:link_to_xbox_site] = item.href
        x[:img] = item.img.src
        x[:region] = region
        x[:currency] = currency
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
          discount = (x[:old_price].to_f - x[:old_price].to_f)/x[:old_price].to_f * 100.to_f
          x[:discount] = discount.to_s
        else
          discount = (x[:old_price].to_f - x[:new_price].to_f)/x[:old_price].to_f * 100.to_f
        x[:discount] = discount.to_s
        end
       
        sales << x
      end
    end
    puts "cantidad de juegos", sales.count
    browser.close
    return sales

 end

 def format_data sales, data

 end

end

# scrape = Scraper.new
# scrape.scraping_xbox_page("https://www.xbox.com/en-us/games/xbox-one?cat=onsale")


