class SaleSerializer < ActiveModel::Serializer
  attributes :status, :name_game, :old_price, :new_price, :link_to_xbox_site, :region, :img, :discount, :currency

end
