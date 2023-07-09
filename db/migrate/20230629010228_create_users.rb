class CreateUsers < ActiveRecord::Migration[7.0]
  def change # rubocop:todo Metrics/MethodLength
    create_table :users do |t|
      t.string :first_name, null: false, limit: 50
      t.string :last_name, null: false, limit: 50
      t.string :nickname, null: false
      t.string :email, null: false, index: { unique: true, name: 'unique_emails' }
      t.string :password_digest, null: false
      t.datetime :activated_at
      t.string :activate_digest
      t.string :remember_digest
      t.string :password_reset_digest
      t.timestamps
    end
  end
end
