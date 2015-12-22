class QuestionSet < ActiveRecord::Base
   has_many :questions, dependent: :destroy
   validates :name, presence: true, uniqueness: true
   validates :description, presence: true
end
