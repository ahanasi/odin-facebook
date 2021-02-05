class Post < ApplicationRecord
  include ActionView::Helpers::DateHelper

  before_validation { image.purge if @delete_image }

  belongs_to :user
  has_many :comments, as: :commentable
  has_many :likes, as: :likeable, dependent: :destroy
  has_one_attached :image
  validates_presence_of :content, unless: :image

  def display_datetime
    yesterday = Time.now - 1.day
    if updated_at >= yesterday.beginning_of_day && updated_at <= yesterday.end_of_day
      "Yesterday #{updated_at.strftime('at%l:%M%P')}"
    elsif updated_at.today?
      distance_of_time_in_words(updated_at, Time.now) + ' ago'
    else
      updated_at.strftime('%B %d at%l:%M%P')
    end
  end

  def delete_image
    @delete_image ||= false
  end

  def delete_image=(value)
    @delete_image = !value.to_i.zero?
  end
end
