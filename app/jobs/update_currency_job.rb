class UpdateCurrencyJob < ApplicationJob
  queue_as :high_priority

  def perform(*args)
    # Do something later
    currencies  = ['USD', 'CLP', 'ARS']
    h = {}
    a = []
    currencies.each do |currency|
     response =  Currency.obtain_value_currencies currency
     from  = response["result"]["from"]
      response["result"]["conversion"].each do |i|
        i["to"] == 'CLP' ? a<< { CLP: i["rate"] } : nil
        i["to"] == 'ARS' ? a<< { ARS: i["rate"] } : nil
        i["to"] == 'USD' ? a<< { USD: i["rate"] } : nil
      end
      h[from.to_sym] = a
      a = []
    end
    element = Currency.all.count
    create_currency(h, element)

  end

  def create_currency hash, is_first_time
    currency_hash = {}
    hash.each do |key_currency, value|
      value.each do |val|
       val.each do |key, val|
         currency_hash[:iso] = key_currency
         currency_hash[key.to_s.downcase]  = val
         currency_hash[key_currency.to_s.downcase] = "1.0"
       end
      end
      is_first_time == 0 ? Currency.create(currency_hash) : Currency.find_by(iso: currency_hash[:iso]).update(currency_hash)
      currency_hash = {}
   end
   p "currencies updated 🎉"
  end
end
