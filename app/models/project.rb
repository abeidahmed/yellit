class Project < ApplicationRecord
  has_many :project_memberships
  has_many :users, through: :project_memberships
  has_many :posts
  has_many :labels

  before_save :normalize_website_url
  before_save :normalize_subdomain

  VALID_URL_REGEX = /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$\z/ix

  validates_presence_of :name, :subdomain
  validates_length_of :name, :website_url, maximum: 255
  validates_length_of :subdomain, maximum: 63
  validates_uniqueness_of :subdomain, case_sensitive: false
  validates_format_of :website_url, with: VALID_URL_REGEX, allow_blank: true

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
