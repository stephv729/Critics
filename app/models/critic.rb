class Critic < ApplicationRecord
  belongs_to :user, counter_cache: true
  belongs_to :criticable, polymorphic: true

  validate :not_blank

  def approved?
    created_at != updated_at || User.admin_ids.include?(user_id)
  end

  private

  def not_blank
    errors.add(:title, "must not be blank") if title.blank?
    errors.add(:body, "must not be blank") if body.blank?
  end
end
