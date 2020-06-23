class Api::DealsController < ApplicationController

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
    data = Sale.group_by_games
    render json: data.to_json, adapter: :json, status: 200
  end

  def new_data
   data = Sale.process_data
   render json: data.to_json, adapter: :json, status: 200
  end

  def obtain_one_game
    r = Sale.name_similar(params[:name_game])
    data = {name_game: params[:name_game], values: r}
    render json: data.to_json, adapter: :json, status: 200
  end

end

