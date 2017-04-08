# json.extract! quiz, :id, :title, :tombstone, :created_at, :updated_at
json.extract! quiz, :id, :title
json.informations do
  json.array! quiz.informations do |information|
    json.extract! information, :id, :challenge_text, :result_text, :source_link
    json.information_type do
      json.extract! information.information_type, :id, :title
      json.category do
        json.extract! information.category, :id, :title
      end
    end
    json.correct_answer do
      json.extract! information.correct_answer, :id, :text
    end
    json.answers do
      json.array! information.answers do |answer|
        json.extract! answer, :id, :text
      end
    end
  end
end