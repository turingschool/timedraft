class User
  attr_reader :username, :id

  def self.login
    User.new(:username => "default")
  end

  def self.login_as(username)
    User.new(:username => username)
  end

  def initialize(params)
    @username = params[:username]
    @id = params[:id] || rand(100)
  end

  def ==(other)
    id == other.id
  end
end
