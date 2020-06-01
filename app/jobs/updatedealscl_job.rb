class UpdatedealsclJob < ApplicationJob
  queue_as :default
  sidekiq_options retry: 3

  def perform(*args)
    item = ["https://www.xbox.com/es-cl/games/xbox-one?cat=onsale&source=lp#%20c-hyperlink", 'Siguiente','cl','CLP']
    browser  = Watir::Browser.new :chrome, args: %w[--headless --no-sandbox --disable-dev-shm-usage --disable-gpu --remote-debugging-port=9222]
    Sale.where(region: 'cl').delete_all
    p "Removed Offers 👍🏻"
    deals = Scraper.scraping_xbox_page(browser, item[0], item[1], item[2],item[3])
    Sale.create(deals)
    p "Chile Region Offers Created 🎉"
    browser.close
    p "Browser closed 😵"
  end
end
