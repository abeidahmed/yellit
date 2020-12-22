class Popovers::FlashComponent < ApplicationComponent
  attr_reader :type, :flash_hash

  TOAST_PROPERTIES = {
    success: { icon: "check", class: "Toast--success" },
    notice: { icon: "info", class: "" },
    alert: { icon: "stop", class: "Toast--error" }
  }

  BANNER_PROPERTIES = {
    success: { class: "flash-success" },
    notice: { class: "" },
    alert: { class: "flash-error" }
  }

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

  def banner_class
    raise_undefined_banner if banner_type.nil?
    banner_type[:class]
  end

  def toast_class
    raise_undefined_toast if toast_type.nil?
    toast_type[:class]
  end

  def toast_icon
    raise_undefined_toast if toast_type.nil?
    toast_type[:icon]
  end

  private
  def toast_type
    TOAST_PROPERTIES[type.to_sym]
  end

  def raise_undefined_toast
    raise "Undefined toast type: #{type}"
  end

  def banner_type
    BANNER_PROPERTIES[type.to_sym]
  end

  def raise_undefined_banner
    raise "Undefined banner type: #{type}"
  end
end
