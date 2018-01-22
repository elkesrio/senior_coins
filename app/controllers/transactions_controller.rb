class TransactionsController < ApplicationController

  def create
    transaction = Transaction.send_coins(params[:sender_id], params[:receiver_id], transaction_params[:amount])
    redirect_back(fallback_location: root_path)

  end

  def transaction_params
    params.require(:transaction).permit(:amount)
  end
end
