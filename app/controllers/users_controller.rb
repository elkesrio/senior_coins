class UsersController < ApplicationController

  def index
    @users = User.all
    @transaction = Transaction.new
  end

end
