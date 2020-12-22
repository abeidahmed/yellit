class Popovers::ToastComponent < ApplicationComponent
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
    BANNER_PROPERTIES.dig(type.to_sym, :class)
  end

  def toast_class
    TOAST_PROPERTIES.dig(type.to_sym, :class)
  end

  def toast_icon
    TOAST_PROPERTIES.dig(type.to_sym, :icon)
  end
end
