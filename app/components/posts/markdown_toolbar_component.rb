class Posts::MarkdownToolbarComponent < ApplicationComponent
  attr_reader :form, :labels

  def initialize(form:, labels:)
    @form   = form
    @labels = labels
  end

  def textarea_id
    "#{form.object_name.gsub(/[\[\]]+/, '_').chop}_body"
  end
end
