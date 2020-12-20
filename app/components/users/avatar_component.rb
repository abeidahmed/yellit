class Users::AvatarComponent < ApplicationComponent
  attr_reader :size

  def initialize(size: "md")
    @size = size
  end

  def avatar_size
    case size
    when "sm"
      "avatar-4"
    when "md"
      "avatar-5"
    else
      raise "Undefined avatar size: #{size}"
    end
  end
end
