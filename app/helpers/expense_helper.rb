module ExpenseHelper
  def create_expense(amount:, comment: '')
    user.expenses << Expense.create(amount: amount, comment: comment)
  end
end
