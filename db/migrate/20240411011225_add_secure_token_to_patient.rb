class AddSecureTokenToPatient < ActiveRecord::Migration[7.1]
  def change
    add_column :patients, :secure_token, :string
  end
end
