# == Schema Information
#
# Table name: transactions
#
#  id          :integer          not null, primary key
#  amount      :integer
#  sender_id   :integer
#  receiver_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Transaction < ApplicationRecord
  belongs_to :sender, :class_name => 'User'
  belongs_to :receiver, :class_name => 'User'
  before_create :validate_transaction, :message => 'The send hasn\'t enough coins'

  def self.send_coins(sender_id, receiver_id, amount)
    transaction = Transaction.new(amount: amount, sender_id: sender_id, receiver_id: receiver_id)
    if transaction.save
      sender = User.find(sender_id)
      receiver = User.find(receiver_id)
      sender.senior_coins -= transaction.amount
      receiver.senior_coins += transaction.amount
      sender.save!
      receiver.save!
    # else

    end
  end

  def validate_transaction
    (  !(User.find(sender_id).senior_coins >= amount) or ( sender_id == receiver_id ) )
    throw(:abort)
  end
end
