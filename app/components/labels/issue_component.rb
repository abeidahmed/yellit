class Labels::IssueComponent < ApplicationComponent
  attr_reader :title

  def initialize(title:, **options)
    super(**options)

    @title = title
  end
end
