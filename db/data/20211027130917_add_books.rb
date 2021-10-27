class AddBooks < ActiveRecord::Migration[6.0]
  def up
    Book.create!(
      title: 'Book 1',
      author: 'Author 1',
      editor: 'Editor 1',
      publisher: 'Publisher 1'
    )
    Book.create!(
      title: 'Book 2',
      author: 'Author 2',
      editor: 'Editor 2',
      publisher: 'Publisher 2'
    )
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
