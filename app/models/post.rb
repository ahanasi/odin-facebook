class Post < ApplicationRecord
  include ActionView::Helpers::DateHelper

  belongs_to :user
  validates_presence_of :content

  def display_datetime
    yesterday = Time.now - 1.day
    if updated_at >= yesterday.beginning_of_day && updated_at <= yesterday.end_of_day
      "Yesterday #{updated_at.strftime('at%l:%M%P')}"
    elsif updated_at.today?
      distance_of_time_in_words(updated_at, Time.now) + " ago"
    else
      updated_at.strftime('%B %d at%l:%M%P')
    end
  end
end
