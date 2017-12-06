json.extract! question, :id, :headline, :content, :created_at, :updated_at, :anon
json.url question_url(question, format: :json)
