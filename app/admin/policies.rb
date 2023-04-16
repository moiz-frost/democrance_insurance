# frozen_string_literal: true

ActiveAdmin.register Policy do
  include Admin::Concerns::Auditable
  include Admin::Concerns::Discardable

  menu label: 'Policies', parent: 'Policy'

  permit_params :premium_cents, :premium_currency, :cover_cents, :cover_currency, :policy_type_id, :customer_id,
                :status, :effective_date, :expiry_date

  actions :all, except: %i[destroy edit]

  config.remove_action_item(:new)

  action_item :quote, only: :show do
    link_to 'Update quote', quote_admin_policy_path(resource) unless resource.active_status?
  end

  action_item :activate, only: :show do
    link_to 'Activate', activate_admin_policy_path(resource), method: :patch unless resource.active_status?
  end

  member_action :quote, method: %i[get post] do
    if request.post?
      policy = resource
      policy.update!(params['policy'].permit!)
      policy.quoted_status!

      flash.notice = t('admin.policy.quoted')
      redirect_to admin_policy_path(policy)
    else
      @policy = resource
    end
  end

  member_action :activate, method: %i[patch] do
    policy = resource

    policy = Policies::ActivateService.new(
      insurance_provider_identifier: policy.customer.insurance_provider.identifier,
      customer_identifier: policy.customer.identifier,
      policy_identifier: policy.identifier
    ).call

    flash.notice = t('admin.policy.activated')
    redirect_to admin_policy_path(policy)
  end

  form do |f|
    f.inputs do
      f.input :premium
      f.input :cover
      f.input :effective_date
      f.input :expiry_date
      f.input :policy_type
      f.input :customer_id, as: :hidden
    end

    f.actions
  end

  show do
    attributes_table do
      row :premium
      row :cover
      row :identifier
      row :policy_type
      row :customer
      row 'Status' do |policy|
        status_tag policy.status, class: 'status_tag no'
      end
      row :effective_date
      row :expiry_date
      row :updated_at
      row :created_at

      history_button(self, resource)
    end

    panel 'Actions' do
      if resource.kept? && !resource.active_status?
        span do
          link_to 'Delete Policy',
                  admin_customer_path(resource),
                  method: :delete,
                  data: { confirm: 'Are you sure?' },
                  class: 'button'
        end
      end

      if resource.discarded?
        span do
          link_to 'Restore Policy',
                  undiscard_admin_customer_path(resource),
                  method: :patch,
                  data: { confirm: 'Are you sure?' },
                  class: 'button'
        end
      end
    end

    active_admin_comments
  end
end
