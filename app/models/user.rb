# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  first_name             :string(255)
#  last_name              :string(255)
#  email                  :string(255)      not null
#  senior_coins           :integer          default(10)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :received_transactions, :class_name => 'Transaction', :foreign_key => 'receiver_id'
  has_many :sent_transactions, :class_name => 'Transaction', :foreign_key => 'sender_id'

  # Returns an array of OpenStruct objects that has the amount and the full name of the sender for every transaction
  def received_transactions_with_sender_full_name
    # Eager load <=> includes with one SQL query
    array_of_hashes = Transaction.eager_load(:sender).where(receiver_id: self.id).map{ |transaction| {amount: transaction.amount, full_name: transaction.sender.first_name + ' ' + transaction.sender.last_name} }
    array_of_objects = array_of_hashes.map{ |received_transaction| JSON.parse(received_transaction.to_json, object_class: OpenStruct) }
  end

  # Same as sent_transactions_with_sender_full_name
  def sent_transactions_with_receiver_full_name
    # Eager load <=> includes with one SQL query
    array_of_hashes = Transaction.eager_load(:receiver).where(sender_id: self.id).map{ |transaction| {amount: transaction.amount, full_name: transaction.receiver.first_name + ' ' + transaction.receiver.last_name} }
    array_of_objects = array_of_hashes.map{ |sent_transaction| JSON.parse(sent_transaction.to_json, object_class: OpenStruct) }
  end
end
