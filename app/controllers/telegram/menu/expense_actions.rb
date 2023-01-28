module Telegram
  module Menu
    module ExpenseActions
      include ActionsBase
      include MenuHelper
      include ExpenseHelper

      def expense!(*)
        question text: t('expense.create', currency: user.currency),
                 context: :log_expense!
      end

      def log_expense!(amount = '', *comment)
        if amount.match(/^\d+$/).blank?
          return question text: t('expense.amount_empty', currency: user.currency),
                          context: :log_expense!
        end

        create_expense(amount: amount, comment: comment.join(' '))

        notify text: t('expense.expense_added'),
               redirect_to_action: :menu!
      end
    end
  end
end
