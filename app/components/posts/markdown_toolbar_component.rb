class Posts::MarkdownToolbarComponent < ApplicationComponent
  attr_reader :form

  def initialize(form:)
    @form = form
  end

  def textarea_id
    "#{form.object_name.gsub(/[\[\]]+/, '_').chop}_body"
  end
end
