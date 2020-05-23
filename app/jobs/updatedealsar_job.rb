class UpdatedealsarJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    item = ["https://www.xbox.com/es-ar/games/xbox-one?cat=onsale&source=lp", 'Siguiente','ar','ARS']
    browser  = Watir::Browser.new :chrome, args: %w[--headless --no-sandbox --disable-dev-shm-usage --disable-gpu --remote-debugging-port=9222]
    Sale.where(region: 'ar').delete_all
    p "Removed Offers 👍🏻"
    deals = Scraper.scraping_xbox_page(browser, item[0], item[1], item[2],item[3])
    Sale.create(deals)
    p "Argentina Region Offers Created 🎉"
    browser.close
    p "Browser closed 😵"
  end
end
