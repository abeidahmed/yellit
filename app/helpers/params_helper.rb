module ParamsHelper
  def has_param?(key, value)
    params[key] == value
  end
end