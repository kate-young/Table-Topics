class QuestionSet < ActiveRecord::Base
   has_many :questions, dependent: :destroy
   validates :name, presence: true, uniqueness: {scope: :user_id} 
   validates :description, presence: true

   scope :used, -> { where(used: true) }
   scope :unused, -> { where(used: false) }

   belongs_to :user

   def reset
     questions.each { |question| question.reset }
   end

   def last_used
     questions.used.order("used_at").last
   end
end
