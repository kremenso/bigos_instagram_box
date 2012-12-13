Rails.application.routes.draw do

  mount BigosInstagramBox::Engine => "/bigos_instagram_box"
  root :to=>"test#index"
end
