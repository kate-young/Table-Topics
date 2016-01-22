class Question < ActiveRecord::Base
  belongs_to :question_set
  validates :value, presence: true, uniqueness: { scope: :question_set_id }
  after_initialize :default_values

  scope :used, -> { where(used: true) }
  scope :unused, -> { where(used: false) }

  def use
    update(used: true)
    touch(:used_at)
  end
  def reset
    update(used: false)
    update(used_at: nil)
  end
  def default_values
    self.used ||= false
  end
end
