# frozen_string_literal: true

json.books @books do |book|
  json.id book.id
  json.title book.title
  json.author book.author
  json.editor book.editor
  json.publisher book.publisher
end
