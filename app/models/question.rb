class Question < ActiveRecord::Base
  belongs_to :question_set
  validates :value, presence: true
  after_initialize :used => false
end
