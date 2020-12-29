class Posts::StatusComponent < Posts::BaseComponent
  STATUSES = {
    draft: { name: "Draft", class: "Label--yellow" },
    published: { name: "Published", class: "Label--green" },
    scheduled: { name: "Scheduled", class: "Label--pink" }
  }

  def status_name
    current_status[:name]
  end

  def label_type
    current_status[:class]
  end

  private
  def current_status
    return STATUSES[:draft] if post_is_draft?

    if post_is_scheduled?
      STATUSES[:scheduled]
    else
      STATUSES[:published]
    end
  end
end
