class CreateInstrumentApplications < ActiveRecord::Migration[7.1]
  def change
    create_table :instrument_applications do |t|
      t.belongs_to :instrument
      t.belongs_to :patient
      t.belongs_to :psychologist
      t.integer :score
      t.integer :status
      t.timestamps
    end
  end
end
