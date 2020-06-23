class Sale < ApplicationRecord

  scope :name_similar, ->(name) {
                         quoted_name = ActiveRecord::Base.connection.quote_string(name)
                         where("similarity(name_game, ?)>= 0.6", name)
                         .order(Arel.sql("similarity(name_game, '#{quoted_name}') DESC")).take(3)}
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

  def self.group_by_games
    all.group_by(&:data_bi_product)
  end

  def self.urls
   offers_group =  all.group_by(&:data_bi_product)
   all_urls =  offers_group.map{|offer| [offer[1].first[:link_to_xbox_site], offer[1].first[:id], offer[1].first[:data_bi_product]]}
   all_urls
  end
end

