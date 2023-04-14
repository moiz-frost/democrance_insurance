# frozen_string_literal: true

ActiveAdmin.register PolicyType do
  include Admin::Concerns::Discardable

  menu label: 'Policy Type', parent: 'Policy'

  permit_params :name, :description

  actions :all, except: [:destroy]

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
    end

    f.actions
  end
end
