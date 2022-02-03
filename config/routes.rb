# frozen_string_literal: true

Rails.application.routes.draw do
  # if Rails.env.development?
  #   mount GoodJob::Engine => 'good_job'
  # end
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: %i[show create update destroy]
      resources :tokens, only: [:create]
      resources :products
      resources :orders, only: %i[index show create]
    end
  end
end
