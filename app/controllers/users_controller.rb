class UsersController < ApplicationController

  def index
    @users = User.where.not(id: current_user.id)
    @transaction = Transaction.new
  end

  def transactions
    user = User.find(params[:id])

    received_transactions = user.received_transactions
    received_transactions = Transaction.includes(:sender_id).where(receiver_id: user.id)


    sent_transactions = Transaction.includes(:receiver_id).where(sender_id: user.id)
    binding.pry
    User.includes(:posts).where('posts.name = ?', 'example')

    sender_ids = received_transactions.map(&:sender_id).uniq
    senders = User.where(id: sender_ids)

    receiver_ids = received_transactions.map(&:sender_id).uniq
    receivers = User.where(id: receiver_ids)

    @received_transactions = received_transactions.map { |transaction| {amount: transaction.amount, sender: senders.select{ |s| s.id == transaction.sender_id}} }

    @sent_transactions = sent_transactions.map { |transaction| {amount: transaction.amount, receiver: receivers.select{ |s| s.id == transaction.receiver_id}} }

    # binding.pry


    # binding.pry
  end

end
