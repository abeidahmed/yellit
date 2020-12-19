class Popovers::ToastComponent < ApplicationComponent
  attr_reader :type, :msg

  def initialize(type:, msg:)
    @type = type
    @msg  = msg
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
