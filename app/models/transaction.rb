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
end
