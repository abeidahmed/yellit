class Navigations::SidebarComponent < ApplicationComponent
  attr_reader :links

  def initialize(links:)
    @links = links
  end
end
