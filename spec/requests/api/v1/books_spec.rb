require 'swagger_helper'

RSpec.describe 'api/v1/books', type: :request do

  let!(:book1) { create :book }
  let!(:book2) { create :book }
  let!( :account) { create :account }

  let!(:access_token) { Auth::JsonWebToken.encode(account_id: account.id) }
  let!(:Authorization) { access_token.to_s }

  path '/api/v1/books' do

    get('list books') do
      parameter name: :Authorization, in: :header, type: :string
      produces 'application/json'

      response(200, 'successful') do

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['books'].count).to eq(2)
        end
      end
    end
  end

  path '/api/v1/books/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'
    parameter name: :Authorization, in: :header, type: :string

    get('show book') do
      response(200, 'successful') do
        let(:id) { book1.id }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['id']).to eq(book1['id'])
        end
      end
    end
  end

  path 'api/v1/books' do
    post 'Creates a book' do
      consumes 'application/json'

      parameter name: :book, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          author: { type: :string },
          publisher: { type: :string },
          editor: { type: :string }
        }
      }

      response '200', 'book created' do
        let(:book) { { title: 'New Book', author: 'New Author'}}

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['title']).to eq('New Book')
          new_books_in_db = Book.where(title: 'New Book').count
          expect(new_books_in_db).to eq(1)
        end
      end
    end
  end
end
