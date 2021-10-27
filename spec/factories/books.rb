FactoryBot.define do
  factory :book, class: Book do
    title { 'Title ' + Faker::Book.unique.title }
    author { 'Author ' + Faker::Book.unique.author }
    publisher { 'Publisher ' + Faker::Book.unique.publisher }
    editor { 'Editor ' + Faker::Name.unique.name }
  end
end