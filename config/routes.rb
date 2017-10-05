Rails.application.routes.draw do
  get 'reputation/index'

  get 'reputation/MyReputation'

  get 'reputation/MyJudgements'

  get 'backoffice/GenerateInvites'

  get 'backoffice/ABTesting'

  get 'wallet/send'

  get 'wallet/withdraw'

  get 'wallet/deposit'

  get 'wallet/transactions'

  get 'access/index'

  get 'access/login'

  get 'chats/myChats'

  get 'chats/chatWith'

  root 'home#index'

  get 'home/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  match ':controller(/:action(/:id))', :via => [:get, :post]
end
