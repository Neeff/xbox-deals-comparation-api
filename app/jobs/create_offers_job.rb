class CreateOffersJob
  include Sidekiq::Worker
  sidekiq_options retry: 3
  def perform(store)
    browser = Watir::Browser.new :chrome, args: %w[--headless --disable-gpu ]
    Sale.where(region: store[2]).delete_all
    p "Removed Offers 👍🏻"
    deals = Scraper.scraping_xbox_page(browser, store[0], store[1], store[2], store[3])
    Sale.create(deals)
    p "#{store[2].upcase} Region Offers Created 🎉"
    browser.close
    p "Browser closed 😵"
  end
end
