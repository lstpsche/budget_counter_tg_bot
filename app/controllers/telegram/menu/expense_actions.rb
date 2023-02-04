module Telegram
  module Menu
    module ExpenseActions
      include ActionsBase
      include MenuHelper
      include ExpenseHelper

      def expense!(*)
        question text: t('expense.create', currency: user.budget.currency),
                 context: :log_expense!
      end

      def log_expense!(amount = '', *comment)
        if amount.match(/(^\d+\.\d+$|^\d+$)/).blank?
          return question text: t('expense.amount_empty', currency: user.budget.currency),
                          context: :log_expense!
        end

        comment_text = comment.join(' ')
        create_expense(amount: amount, comment: comment_text)

        notify text: t('expense.expense_added', amount: stylize_expense_amount(amount), comment: comment_text),
               redirect_to_action: :menu!
      end
    end
  end
end
