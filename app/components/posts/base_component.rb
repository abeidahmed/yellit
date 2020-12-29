class Posts::BaseComponent < ApplicationComponent
  attr_reader :post

  def initialize(post:)
    @post = post
  end

  def post_is_draft?
    post.published_at.blank?
  end

  def post_is_scheduled?
    post.published_at > Time.zone.now
  end

  def post_title
    post.title
  end
end