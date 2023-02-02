class User < ApplicationRecord
  has_one :budget, dependent: :destroy
  has_many :expenses, dependent: :destroy

  after_create :create_budget
end
