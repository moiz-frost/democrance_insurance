class CreateInsuranceProviders < ActiveRecord::Migration[7.0]
  def change
    create_table :insurance_providers do |t|
      t.string :name, null: false, index: true
      t.string :identifier, null: false, index: true, comment: 'External ID for reference'

      # Soft deletes field
      t.datetime :discarded_at, index: true, comment: 'Used for soft deletes'

      t.timestamps
    end
  end
end
