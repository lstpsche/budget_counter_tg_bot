class CreateExpenses < ActiveRecord::Migration[7.0]
  def change
    create_table :expenses do |t|
      t.float :amount, null: false
      t.string :comment, null: false, default: ''

      t.belongs_to :user

      t.timestamps
    end
  end
end
