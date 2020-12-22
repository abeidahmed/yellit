class Popovers::ToastComponent < ApplicationComponent
  attr_reader :type, :flash_hash

  def initialize(type:, flash_hash:)
    @type        = type
    @flash_hash  = flash_hash
  end

  def message
    flash_hash[:message]
  end

  def show_banner?
    flash_hash.fetch(:banner, false)
  end

  def flash_class
    case type
    when "success"
      "flash-success"
    when "notice"
      ""
    when "alert"
      "flash-error"
    else
      raise "Undefined flash type: #{type}"
    end
  end

  def toast_class
    case type
    when "success"
      "Toast--success"
    when "notice"
      "Toast--info"
    when "alert"
      "Toast--error"
    else
      raise "Undefined toast type: #{type}"
    end
  end

  def toast_icon
    case type
    when "success"
      "check"
    when "notice"
      "info"
    when "alert"
      "stop"
    else
      raise "Undefined toast type: #{type}"
    end
  end
end
