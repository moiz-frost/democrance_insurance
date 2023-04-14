# frozen_string_literal: true

ActiveAdmin.register InsuranceProvider do
  include Admin::Concerns::Auditable
  include Admin::Concerns::Discardable

  permit_params :name

  actions :all, except: [:destroy]

  index do
    id_column
    column :identifier
    column :name
    column :created_at
    column :updated_at
    column :deleted, &:discarded?

    actions defaults: false do |customer|
      item 'View', admin_insurance_provider_path(customer), class: 'member_link'
    end
  end

  form do |f|
    f.inputs do
      f.input :name
    end

    f.actions
  end

  show do
    columns do
      column do
        attributes_table do
          row :name
          row :updated_at
          row :created_at

          history_button(self, resource)
        end

        panel 'Actions' do
          if resource.kept?
            span do
              link_to 'Delete Insurance Provider',
                      admin_customer_path(resource),
                      method: :delete,
                      data: { confirm: 'Are you sure?' },
                      class: 'button'
            end
          end

          if resource.discarded?
            span do
              link_to 'Restore Insurance Provider',
                      undiscard_admin_customer_path(resource),
                      method: :patch,
                      data: { confirm: 'Are you sure?' },
                      class: 'button'
            end
          end

          span do
            link_to 'Create customer',
                    new_admin_customer_path(customer: {
                                              insurance_provider_id: resource.id
                                            }),
                    method: :get,
                    class: 'button'
          end
        end

        active_admin_comments
      end

      column do
        panel 'Customers' do
          paginated_collection(
            resource.customers.order('created_at DESC').page(params[:page]).per(10),
            download_links: false
          ) do
            table_for collection do
              column('View') do |customer|
                link_to customer.id, admin_customer_path(customer.id)
              end
              column :first_name
              column :last_name
              column :identifier
              column '' do |customer|
                link_to 'View', admin_customer_path(customer.id)
              end
              # column(:status) do |o|
              #   status_tag(o.current_stage, class: (if o.financed? && !o.account.delinquent?
              #                                         'ok'
              #                                       elsif o.canceled? || o.account&.delinquent?
              #                                         'red'
              #                                       elsif o.draft?
              #                                         ''
              #                                       else
              #                                         'orange'
              #                                       end).to_s)
              # end
            end
          end
        end
      end
    end
  end
end
