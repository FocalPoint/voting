class Question < ActiveRecord::Base
  belongs_to :subject
  belongs_to :user
  has_many :answers
  has_many :question_votes
end
