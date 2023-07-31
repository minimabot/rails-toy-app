class CreateRolesAndPermissions < ActiveRecord::Migration[7.0]
  def change # rubocop:todo Metrics/MethodLength
    create_table :roles do |t|
      t.string :name, null: false
      t.timestamps
    end

    create_table :permissions do |t|
      t.string :name, null: false
      t.timestamps
    end

    create_table :role_permissions, id: false do |t|
      t.belongs_to :role, null: false
      t.belongs_to :permission, null: false
    end

    add_foreign_key :role_permissions, :roles
    add_foreign_key :role_permissions, :permissions

    add_index :roles, [:name], unique: true
    add_index :permissions, [:name], unique: true
    add_index :role_permissions, %i[role_id permission_id], unique: true
  end
end
