class CreateCurrencies < ActiveRecord::Migration[6.0]
  def change
    create_table :currencies do |t|
      t.string :iso
      t.string :usd
      t.string :clp
      t.string :ars

      t.timestamps
    end
  end
end
