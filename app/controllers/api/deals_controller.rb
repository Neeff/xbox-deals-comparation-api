class Api::DealsController < ApplicationController

  def deals_us
    browser  = Watir::Browser.new :chrome, args: %w[--headless --no-sandbox --disable-dev-shm-usage --disable-gpu --remote-debugging-port=9222]
    deals = Scraper.scraping_xbox_page(browser, "https://www.xbox.com/en-us/games/xbox-one?cat=onsale", 'Next','us','USD')
    sale = Sale.create(deals)
    browser.close
    render json: 'ok! 🎉', adapter: :json, status: 201
  end

  def deals_cl

    deals = Scraper.scraping_xbox_page("https://www.xbox.com/es-cl/games/xbox-one?cat=onsale&source=lp#%20c-hyperlink", 'Siguiente','cl','CLP')
    sale = Sale.create(deals)
    render json: 'ok! 🎉', adapter: :json, status: 201
  end

  def deals_ar
    deals = Scraper.scraping_xbox_page("https://www.xbox.com/es-ar/games/xbox-one?cat=onsale&source=lp", 'Siguiente','ar','ARS')
    sale = Sale.create(deals)
    render json: 'ok! 🎉', adapter: :json, status: 201
  end

  def get_deals_us
    deals = Sale.deals_us
    render json: SaleSerializer.new(deals).serialized_json, adapter: :json, status: 200
  end

  def get_deals_cl
    deals = Sale.deals_cl
    render json: SaleSerializer.new(deals).serialized_json, adapter: :json, status: 200
  end

  def get_deals_ar
    deals = Sale.deals_ar
    render json: SaleSerializer.new(deals).serialized_json, adapter: :json, status: 200
  end

  def get_all_deals
    deals = Sale.all
    render json: SaleSerializer.new(deals).serialized_json, adapter: :json, status: 200
  end

  def quantity
    data = Sale.count_by_region
    render json: data, adapter: :json, status: 200
  end

  def group_by_name_game
    data = Sale.group_by_name
    render json: data.to_json, adapter: :json, status: 200
  end

end

