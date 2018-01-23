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
  validate :validate_transaction_amount
  validate :validate_transaction_members

  # Method called after that the transaction has been saved successfully (passed the validations below), it sends the money from the receiver to the sender
  def send_coins
    sender = User.find(sender_id)
    receiver = User.find(receiver_id)
    sender.senior_coins -= amount
    receiver.senior_coins += amount
    sender.save!
    receiver.save!
  end

  # Validates the amount of the transaction (must be not 0 and greater than what the sender has)
  def validate_transaction_amount
    if User.find(sender_id).senior_coins < amount or amount == 0
      errors.add(:amount, "can't be greater than what you have")
    end
  end

  # Validates the receiver and the sender are different
  def validate_transaction_members
    if ( sender_id == receiver_id )
      errors.add(:sender, "can't be the receiver")
    end
  end

end
