class Expense < ApplicationRecord
  validates :amount, presence: true

  belongs_to :user
end
