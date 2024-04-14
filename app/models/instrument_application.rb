class InstrumentApplication < ActiveRecord::Base
  belongs_to :instrument
  belongs_to :patient
  belongs_to :psychologist

  enum :status, %i[pending in_progress finished], default: 'pending'
end