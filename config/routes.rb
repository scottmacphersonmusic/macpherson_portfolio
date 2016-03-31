Rails.application.routes.draw do
  mount PdfjsViewer::Rails::Engine => "/pdfjs", as: 'pdfjs'

  resources :transcriptions
  root 'transcriptions#index'
end
