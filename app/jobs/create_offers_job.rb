class CreateOffersJob
  include Sidekiq::Worker
  sidekiq_options retry: 3
  def perform
    stores =
    [
      { url: "https://www.xbox.com/en-us/games/xbox-one?cat=onsale", text: 'Next', region: 'us', currency: 'USD'},
      { url: "https://www.xbox.com/es-cl/games/xbox-one?cat=onsale&source=lp#%20c-hyperlink", text: 'Siguiente', region:'cl',currency: 'CLP'},
      { url: "https://www.xbox.com/es-ar/games/xbox-one?cat=onsale&source=lp", text: 'Siguiente', region: 'ar', currency: 'ARS'}
    ]

    browser = Watir::Browser.new :chrome, args: %w[--headless --disable-gpu ]
    Sale.delete_all
    p "Removed Offers 👍"
    raw_data = Scraper.scraper_page(browser, stores)
    deals    = Scraper.proccess_data(raw_data)
    Sale.create(deals)
    p "Region Offers Created 🎉"
    browser.close
    p "Browser closed 😵"
  end
end
