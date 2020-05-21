class AddCurrencyToSale < ActiveRecord::Migration[6.0]
  def change
    add_column :sales, :currency, :string
  end
end
