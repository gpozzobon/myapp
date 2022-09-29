Rails.application.routes.draw do
  resources :authors
  resources :songs
  
  get 'home/about'
  root 'home#index'

  get 'export_songs', to: 'songs#report', as: 'song_report'
  get 'export_authors', to: 'authors#report', as: 'author_report'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
