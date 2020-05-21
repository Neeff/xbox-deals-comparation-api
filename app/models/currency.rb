class Currency < ApplicationRecord
  include HTTParty

  def self.obtain_value_currencies currency
    baseUrl = "https://api.cambio.today/v1/full/#{currency}/json?key=4397|xsHNqQWVMkHiJ77UKBs4V~MMgkaNZ*TL"
    r = HTTParty.get(baseUrl, format: :plain)
    response  = JSON.parse(r)

  end

  def self.currencies
    Currency.all
  end

end
