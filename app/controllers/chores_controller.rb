class ChoresController < ApplicationController
  

  before_action :confirm_logged_in

  def index
    @chores = Chore.all
  end

  def show
    @chore = Chore.find(params[:id])
  end

  def new
    @chore = Chore.new
  end

  def create
    log("create new chore")
    @chore = Chore.new(choreParams)
    @chore.userIDHiring_id = session[:user_id]
    conv = Converter.new
    @chore.price = conv.to_i(@chore.text_price)
    
    if isBalanceOK
      puts("============= Balance is ok ==============")
      if @chore.save
        #save succeed, redirect
        flash[:notice] = "Chore created successfully"
        redirect_to(:action => 'index')
      else
        #redisplay form so user can fix
        render('new')
      end
    else
      puts("============= Balance is not ok ==============")

      flash[:notice] = "You only have #{balance} in your wallet,
        please top it up or change your price."
       render('new')
    end

    #new object using form parameters
    #save object

  end


  def edit
    @chore = Chore.find(params[:id])
  end

  def update
    log("update existing chore")
    #Find existing using form parameters
    @chore = Chore.find(params[:id])


    if @chore.update_attributes(choreParams)
      #save succeed, redirect
      flash[:notice] = "Chore updated successfully"
      redirect_to(:action => 'show', :id => @chore.id)
    else
      #redisplay form so user can fix
      render('edit')
    end
  end


 def send_work_offer
    log("send work offer")
    @chore = Chore.find(params[:chore_id])

    myid = session[:user_id]
    other_id = @chore.userIDHiring_id
    puts("===========  printing ================")
    puts(other_id)

    @work_offer = WorkOffer.new(:chore_id => params[:chore_id], :user_id => myid)
    @chore.work_offers << @work_offer

       # add user id from both users to chat.
       # If the chat doesn't exist, create it.
    chat = Chat.where(:userA_id => @chore.userIDHiring_id).where(:userB_id => myid).first
    if(chat.nil?)
      #reverse the roles, see if you can find a chat then
      chat = Chat.where(:userB_id => @chore.userIDHiring_id).where(:userA_id => myid).first
    end

    if(chat.nil?)
        puts("============= Creating new chat ==============")
        #I need a user ID on the work offer.
        chat = Chat.new(:userA_id => @chore.userIDHiring_id, :userB_id => myid)
        chat.save
    end

    message = Message.new(:message => params[:message_text], :user_id => myid)
    chat.messages << message

    puts(message.message)

    redirect_to(:controller => 'chats', :action => 'chatWith', :id =>chat.id)
  end


  def display_my_work
    log("display my work")
    @myOffers = WorkOffer.where(:user_id => session[:user_id])
    @choresMap = Hash.new
    @statusMap = Hash.new
    @myOffers.each do |o|
      @choresMap[o] = Chore.where(:id => o.chore_id).first
      @statusMap[o] = calculateStatus(o)
      puts("=========================== hi there")
      puts(o.chore_id)
    end
    #@chore = Chore.where(:id => @myOffers.chore_id).first
  end




  def mark_work_complete
    log("mark_work_complete")
    work = WorkOffer.where(:id =>params[:id]).first
    work.work_complete_time = Time.new
    work.save
  end

  def display_completed_work
    log("display_completed_work")
    #Get my chores.
    # of these, take the ones that have offers.
    # of these, take the ones that have completed.

    @myChores = Chore.where(:userIDHiring_id => session[:user_id])

    @workOffers = Hash.new

    toRemove = Array.new
    @statusMap = Hash.new
    @myChores.each do |c|
      @workOffers[c] = WorkOffer.where(:chore_id => c.id).first
      #where.not(:work_complete_time => nil).where(:work_complete_accepted_time => nil).first
      unless @workOffers[c].nil?
        @statusMap[@workOffers[c]] = calculateStatus(@workOffers[c])
      end
    end 
  end


  def accept_work
    log("accept_work")
    work = WorkOffer.where(:id =>params[:id]).first
    work.work_complete_accepted_time = Time.new
    work.save


    distributer = ValueDistributer.new
    distributer.make_transactions(work)

    # tx = Transaction.new(:from_user => session[:user_id], :to_user => work.user_id, :amount => work.chore.price)
    # tx.save

    #Find out who invited the user that sends tx
    # and who received the tx

    #and then who invited the previous layers as well.

    #Now you have all the info needed to generate a set of transactions that distribute the gains
    #according to the system

  end

  def makeMoney
    log("click makeMoney")
    @choresRelevant = Array.new
    @choresAll = Chore.all
    @choresAll.each do |c|
      if c.work_offers.empty?
        @choresRelevant << c
      end
    end
  end

  def requestChore
      @chore = Chore.find(params[:id])
  end

  def delete
     @chore = Chore.find(params[:id])
  end

  def destroy
     chore = Chore.find(params[:id])
     chore.destroy
     flash[:notice] = "Chore '#{chore.title}' destroyed successfully"
     redirect_to(:action => "index")
  end

  private
    def choreParams
      params.require(:chore).permit(:title, 
        :description, :address, :userIDHiring_id, :text_price)
    end

  private
    def workOfferParams
      params.require(:chore_id).permit(:chore_id)
    end

  private
    def messageParams
      params.require(:message).permit(:message, :chat_id)
    end

  private 
    def calculateStatus(offer)

      result = ""

      unless offer.nil?
        result = "Work offer submitted"
      end

      unless offer.nil? or offer.work_complete_time.nil?
        result = "Work complete"
      end

      unless offer.nil? or offer.work_complete_accepted_time.nil?
        result = "Work accepted"
      end
      return result
    end

    private 
      def isBalanceOK
        return balance >= @chore.price.to_i
      end

      def balance
        wal = WalletController.new
        bal = wal.calculateBalance(session[:user_id])
        return bal
      end
end
