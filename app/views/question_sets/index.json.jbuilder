json.array!(@question_sets) do |question_set|
  json.extract! question_set, :id
  json.url question_set_url(question_set, format: :json)
end
