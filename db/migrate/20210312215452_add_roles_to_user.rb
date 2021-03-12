class AddRolesToUser < ActiveRecord::Migration[6.0]
  def change
    #Is this user an admin?
    add_column :users, :admin, :boolean
    #Is this user a lecturer?
    add_column :users, :lecturer, :boolean
  end
end
