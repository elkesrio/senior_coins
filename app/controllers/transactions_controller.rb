class TransactionsController < ApplicationController

  def create
    transaction = Transaction.new(sender_id: params[:sender_id], receiver_id: params[:receiver_id], amount: transaction_params[:amount])
    if transaction.save
      transaction.send_coins
      flash[:notice] = ["The transaction has been done succesfully"]
    else
      flash[:error] = transaction.errors.full_messages
    end
    redirect_to users_path
  end

  def transaction_params
    params.require(:transaction).permit(:amount)
  end
end
