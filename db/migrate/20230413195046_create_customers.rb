class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string :first_name, null: false, index: true
      t.string :last_name, null: false, index: true
      t.string :email
      t.string :international_phone_number
      t.string :currency
      t.string :country
      t.string :city
      t.string :identifier, null: false, index: true, comment: 'External ID for reference'

      t.date :dob, null: false, index: true

      t.references :insurance_provider, index: true, foreign_key: { to_table: :insurance_providers }

      # Soft deletes field
      t.datetime :discarded_at, index: true, comment: 'Used for soft deletes'

      # Composite index for searching in order
      t.index [:first_name, :last_name, :dob]

      t.timestamps
    end
  end
end
