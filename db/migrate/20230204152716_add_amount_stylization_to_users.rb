class AddAmountStylizationToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :amount_stylization, :boolean, null: false, default: true
  end
end
