class Information < ApplicationRecord
  belongs_to :information_type
  belongs_to :correct_answer
  belongs_to :category
end
