class AddColumsToSales < ActiveRecord::Migration[6.0]
  def change
    add_column :sales, :rating, :string
    add_column :sales, :data_bi_product, :string
  end
end
