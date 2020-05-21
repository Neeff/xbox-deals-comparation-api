class AddDiscountToSale < ActiveRecord::Migration[6.0]
  def change
    add_column :sales, :discount, :string
  end
end
