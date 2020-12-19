class Authentication
  def initialize(params)
    @email_address = params[:email_address].downcase
    @password      = params[:password]
  end

  def authenticated?
    !!user
  end

  def user
    find_by_credentials
  end

  private
  attr_reader :email_address, :password

  def find_by_credentials
    @user ||= User.find_by_email_address(email_address)
    return nil unless @user
    @user.authenticate(password) ? @user : nil
  end
end