class User < ApplicationRecord
  include ProjectTenant

  has_many :project_memberships
  has_many :projects, through: :project_memberships

  has_secure_password

  before_create :generate_auth_token
  before_save :normalize_email_address
  before_validation :trim_white_spaces

  VALID_EMAIL_REGEX   = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  MIN_PASSWORD_LENGTH = 6
  FULL_NAME_EXCLUSION = %w(anonymous)

  validates_presence_of :email_address, :full_name
  validates_uniqueness_of :email_address, case_sensitive: false
  validates_length_of :email_address, :full_name, maximum: 255
  validates_format_of :email_address, with: VALID_EMAIL_REGEX
  validates_length_of :password, minimum: MIN_PASSWORD_LENGTH, on: :create
  validate :full_name_is_not_reserved

  private
  def generate_auth_token
    generate_token(:auth_token)
  end

  def normalize_email_address
    self.email_address = email_address.downcase
  end

  def trim_white_spaces
    self.email_address = email_address.strip if email_address
    self.full_name     = full_name.strip if full_name
  end

  def full_name_is_not_reserved
    errors.add(:full_name, "can't be #{full_name}") if FULL_NAME_EXCLUSION.include? full_name.to_s.strip.downcase
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
end
