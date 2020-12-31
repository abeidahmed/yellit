class User < ApplicationRecord
  include ProjectTenant

  has_many :project_memberships, dependent: :destroy
  has_many :projects, through: :project_memberships

  has_secure_password

  before_validation :trim_white_spaces
  before_save :normalize_email_address
  before_create :generate_auth_token

  VALID_EMAIL_REGEX   = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  MIN_PASSWORD_LENGTH = 6
  FULL_NAME_EXCLUSION = %w[anonymous].freeze

  # rubocop:disable Rails/UniqueValidationWithoutIndex, Layout/LineLength
  validates :email_address, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }
  # rubocop:enable Rails/UniqueValidationWithoutIndex, Layout/LineLength
  validates :full_name, presence: true, length: { maximum: 255 }
  validates :password, length: { minimum: MIN_PASSWORD_LENGTH }, on: :create

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

  def generate_token(column)
    loop do
      self[column] = SecureRandom.urlsafe_base64
      break unless User.exists?(column => self[column])
    end
  end
end
