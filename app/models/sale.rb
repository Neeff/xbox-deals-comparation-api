class Sale < ApplicationRecord

def self.deals_ar
  where(region: 'ar')
end

def self.deals_us
  where(region: 'us')
end

def self.deals_cl
  where(region: 'cl')
end

def self.count_by_region 
  count_by_region = { }
  pluck(:region).uniq.each do |region|
    count_by_region[region.to_s] = where(region: region).count
  end
  count_by_region
end

def self.group_by_name
  select(:status, :name_game, :old_price, :new_price, :link_to_xbox_site, :region, :img, :discount, :currency)
  .group_by(&:name_game)
end



end

