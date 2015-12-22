class Question < ActiveRecord::Base
  belongs_to :question_set
  validates :value, presence: true, uniqueness: { scope: :question_set_id }
  after_initialize :used => false
end
