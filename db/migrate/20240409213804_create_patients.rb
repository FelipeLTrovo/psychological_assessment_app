class CreatePatients < ActiveRecord::Migration[7.1]
  def change
    create_table :patients do |t|
      t.string :name
      t.string :email
      t.string :cpf
      t.date :birthdate
      t.references :instrument, foreign_key: true

      t.timestamps
    end
  end
end
