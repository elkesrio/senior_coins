class UsersController < ApplicationController

  def index
    @users = User.where.not(id: current_user.id)
    @transaction = Transaction.new
  end

  def transactions
    user = User.find(params[:id])
    @sent_transactions = user.sent_transactions_with_receiver_full_name
    @received_transactions = user.received_transactions_with_sender_full_name
  end

end
