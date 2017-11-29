Rails.application.routes.draw do
  # get 'downloads/show'

  get 'download_show'=>"students#download_pdf" ,:as=>"downloads_pdf"
  get 'delivered_student'=>"home#delivered" 

  get 'students_download'=>'students#student_pdf'

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  resources :courses
  resources :students
  # resources :students do 
  #   resource :download, only: [:show]
  # end
  root 'home#index'


end
