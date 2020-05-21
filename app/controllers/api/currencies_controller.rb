class Api::CurrenciesController < ApplicationController

  def get_currencies
    currencies = Currency.currencies 
    render json: currencies, adpter: :json, status: 200
    end
  end
