class AddAccount < ActiveRecord::Migration[6.0]
  def up
    Account.create!(
      email: 'test@example.com',
      password: '123456'
    )
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
