class QuestionSet < ActiveRecord::Base
   has_many :questions, dependent: :destroy
   validates :name, presence: true, uniqueness: true
   validates :description, presence: true

   scope :used, -> { where(used: true) }
   scope :unused, -> { where(used: false) }

   def reset
     questions.each { |question| question.reset }
   end
end
