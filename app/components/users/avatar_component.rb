class Users::AvatarComponent < ApplicationComponent
  attr_reader :size

  def initialize(size: "md")
    @size = size
  end

  def avatar_size
    case size
    when "xs"
      "avatar-2"
    when "sm"
      "avatar-4"
    when "md"
      "avatar-5"
    when "lg"
      "avatar-6"
    else
      raise "Undefined avatar size: #{size}"
    end
  end
end
