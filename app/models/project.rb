class Project < ApplicationRecord
  has_many :project_memberships, dependent: :destroy
  has_many :users, through: :project_memberships
  has_many :posts, dependent: :destroy
  has_many :labels, dependent: :destroy

  before_save :normalize_website_url
  before_save :normalize_subdomain

  VALID_URL_REGEX = /\A(http|https):\/\/[a-z0-9]+([\-.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$\z/ix # rubocop:disable Style/RegexpLiteral

  validates :name, presence: true, length: { maximum: 255 }
  validates :subdomain, presence: true, length: { maximum: 63 }, uniqueness: { case_sensitive: false } # rubocop:disable Rails/UniqueValidationWithoutIndex
  validates :website_url, length: { maximum: 255 }, format: { with: VALID_URL_REGEX }, allow_blank: true

  def total_owners
    project_memberships.users_with_role("owner").size
  end

  private

  def normalize_website_url
    self.website_url = website_url.downcase
  end

  def normalize_subdomain
    self.subdomain = subdomain.downcase
  end
end
