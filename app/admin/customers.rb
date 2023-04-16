# frozen_string_literal: true

ActiveAdmin.register Customer do
  include Admin::Concerns::Auditable

  permit_params :first_name, :last_name, :email, :international_phone_number, :country, :city, :dob,
                :insurance_provider_id

  actions :all, except: [:destroy]

  filter :identifier
  filter :first_name
  filter :last_name
  filter :email
  filter :international_phone_number
  filter :policy_type, as: :select, label: 'Policy Type', collection: PolicyType.all.pluck(:name), filters: [:eq]
  filter :country
  filter :city
  filter :dob

  index do
    id_column
    column :identifier
    column :first_name
    column :last_name
    column :email
    column :international_phone_number
    column :country
    column :city
    column :created_at
    column :updated_at
    column :deleted, &:discarded?

    actions defaults: false do |customer|
      item 'View', admin_customer_path(customer), class: 'member_link'
    end
  end

  form do |f|
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :international_phone_number
      f.input :country
      f.input :city
      f.input :dob
      f.input :insurance_provider
    end

    f.actions
  end

  show do
    columns do
      column do
        attributes_table do
          row :first_name
          row :last_name
          row :email
          row :international_phone_number
          row :country
          row :city
          row :dob
          row :insurance_provider
          row :updated_at
          row :created_at

          history_button(self, resource)
        end

        panel 'Actions' do
          if resource.kept?
            span do
              link_to 'Delete Merchant',
                      admin_customer_path(resource),
                      method: :delete,
                      data: { confirm: 'Are you sure?' },
                      class: 'button'
            end
          end

          if resource.discarded?
            span do
              link_to 'Restore Merchant',
                      undiscard_admin_customer_path(resource),
                      method: :patch,
                      data: { confirm: 'Are you sure?' },
                      class: 'button'
            end
          end

          span do
            link_to 'Create policy',
                    new_admin_policy_path(policy: {
                                            customer_id: resource.id
                                          }),
                    method: :get,
                    class: 'button'
          end
        end

        active_admin_comments
      end

      column do
        panel 'Policies' do
          paginated_collection(
            resource.policies.order('created_at DESC').page(params[:page]).per(10),
            download_links: false
          ) do
            table_for collection do
              column('Identifier') do |policy|
                link_to policy.identifier, admin_policy_path(policy.id)
              end
              column :premium
              column :cover
              column(:status) do |policy|
                status_tag policy.status, class: 'status_tag no'
              end
              column :effective_date
              column :expiry_date
              column '' do |policy|
                link_to 'View', admin_policy_path(policy.id)
              end
            end
          end
        end
      end
    end
  end
end
