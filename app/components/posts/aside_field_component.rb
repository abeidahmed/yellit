class Posts::AsideFieldComponent < Posts::BaseComponent
  attr_reader :form

  def initialize(form:, **args)
    super(**args)

    @form = form
  end
end
