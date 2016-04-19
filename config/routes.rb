Rails.application.routes.draw do
  devise_for :users
  mount PdfjsViewer::Rails::Engine => "/pdfjs", as: 'pdfjs'

  resources :transcriptions
  root 'transcriptions#index'
end
