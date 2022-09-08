class Micropost < ApplicationRecord
  belongs_to :user

  has_one_attached :image

  delegate :name, to: :user, prefix: true
  validates :content, presence: true, length: {maximum: Settings.micropost
                                                                .length
                                                                .content_max}
  validates :image, content_type: {in: %w(image/jpeg image/gif image/png),
                                   message: I18n.t(".invalid_image_format")},
    size: {less_than: Settings.image.size.megabytes, message:
      I18n.t(".invalid_image_size")}

  scope :seach_by_created_at_desc, ->{order created_at: :desc}
  scope :by_user, ->(id){where "user_id = ?", id}
  scope :search_following, ->(following_ids) { where user_id:
    following_ids }

  def display_image
    image.variant resize_to_limit: Settings.micropost.image.resize
  end
end
