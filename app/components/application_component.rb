class ApplicationComponent < ViewComponent::Base
  include SvgHelper
  include Turbo::FramesHelper

  attr_reader :data, :options, :style

  def initialize(data: nil, style: nil, **options)
    @data    = data
    @options = options
    @style   = style
  end

  def data_attributes
    return if data.nil?

    attrs = ""
    data.each { |attr, value| attrs += "data-#{attr.to_s.dasherize}=#{value} " }
    attrs.strip
  end

  def html_attributes
    attrs = ""
    options.each { |attr, value| attrs += "#{attr}=#{value} " }
    attrs.strip
  end
end
