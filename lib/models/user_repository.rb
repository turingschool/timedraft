require './lib/models/user'

class UserRepository
  attr_accessor :users

  def initialize
    @users = []
  end

  def create_user(params)
    user = User.new(:username => params[:username])
    self.users << user
    return user
  end

  def login_as(username)
    users.detect{|user| user.username == username }
  end
end
