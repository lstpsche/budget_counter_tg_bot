module ExpenseHelper
  DIGITS_STYLIZER = {
    '1' => '1️⃣',
    '2' => '2️⃣',
    '3' => '3️⃣',
    '4' => '4️⃣',
    '5' => '5️⃣',
    '6' => '6️⃣',
    '7' => '7️⃣',
    '8' => '8️⃣',
    '9' => '9️⃣',
    '0' => '0️⃣'
  }.freeze

  def create_expense(amount:, comment: '')
    user.expenses << Expense.create(amount: amount, comment: comment)
  end

  def stylize_expense_amount(amount)
    amount.split('').map { |sign| DIGITS_STYLIZER.fetch(sign, sign) }.join
  end
end
