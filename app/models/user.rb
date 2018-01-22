# == Schema Information
#
# Table name: users
#
#  id           :integer          not null, primary key
#  first_name   :string(255)
#  last_name    :string(255)
#  email        :string(255)
#  senior_coins :integer          default(10)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class User < ApplicationRecord
  has_many :received_transactions, :class_name => 'Transaction', :foreign_key => 'receiver_id'
  has_many :sent_transactions, :class_name => 'Transaction', :foreign_key => 'sender_id'
end
