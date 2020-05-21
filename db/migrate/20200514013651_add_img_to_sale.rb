class AddImgToSale < ActiveRecord::Migration[6.0]
  def change
    add_column :sales, :img, :string
  end
end
