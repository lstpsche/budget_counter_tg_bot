class CreateBudgets < ActiveRecord::Migration[7.0]
  def change
    create_table :budgets do |t|
      t.string :currency, null: false, default: 'USD'
      t.float :monthly_budget, null: false, default: 0.0
      t.integer :first_day_of_month, null: false, default: 1

      t.belongs_to :user

      t.timestamps
    end

    remove_column :users, :currency, :string, null: false, default: 'USD'
    remove_column :users, :monthly_budget, :float, null: false, default: 0.0
    remove_column :users, :salary_day, :integer, null: false, default: 1
  end
end
