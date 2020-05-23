class UpdateDealsJob < ApplicationJob
  queue_as :high_priority

  def perform(*args)
    Sale.delete_all
    browser  = Watir::Browser.new :chrome, args: %w[--headless --no-sandbox --disable-dev-shm-usage --disable-gpu --remote-debugging-port=9222]
    data = [["https://www.xbox.com/en-us/games/xbox-one?cat=onsale", 'Next','us','USD'],["https://www.xbox.com/es-cl/games/xbox-one?cat=onsale&source=lp#%20c-hyperlink", 'Siguiente','cl','CLP'],["https://www.xbox.com/es-ar/games/xbox-one?cat=onsale&source=lp", 'Siguiente','ar','ARS']]

    data.each do |item|
      puts "#{item[0]} , #{item[1]}, #{item[2]},#{item[3]}"
      s = Scraper.new
      deals = s.scraping_xbox_page(browser, item[0], item[1], item[2],item[3])
      Sale.create(deals)
    end
    browser.close
  end 


end
