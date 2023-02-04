class User < ApplicationRecord
  has_one :budget, dependent: :destroy
  has_many :expenses, dependent: :destroy

  after_create :create_budget

  def toggle_amount_stylization
    update(amount_stylization: !amount_stylization)
  end
end
