class Sale < ApplicationRecord

def self.deals_ar
  where(currency: 'ARS')
end

def self.deals_us
  where(currency:'USD')
end

def self.deals_cl
  where(currency: 'CLP')
end

def self.count_by_region
  count_by_region = { }
  pluck(:currency).uniq.each do |region|
    count_by_region[region.to_s] = where(currency: region).count
  end
  count_by_region
end

def self.group_by_name
  all.group_by(&:name_game)
end



end

