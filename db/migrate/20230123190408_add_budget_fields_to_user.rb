class AddBudgetFieldsToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :currency, :string, null: false, default: 'USD'
    add_column :users, :monthly_budget, :float, null: false, default: 0.0
    add_column :users, :salary_day, :integer, null: false, default: 1
  end
end
