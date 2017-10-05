class WalletController < ApplicationController

  def build_tx
    log("build_tx loaded")
    conv = Converter.new
  	@balance = conv.to_s(calculateBalance(session[:user_id]))
  end

  def send_tx
    log("send_tx loaded")
  	@tx = Transaction.new(txParams)

    conv = Converter.new
    @tx.amount = conv.to_i(@tx.text_amo)
  	@tx.from_user = session[:user_id]

  	if(@tx.amount <= calculateBalance(session[:user_id]))
  		@tx.save
      log("send_tx successfully executed")
  		flash[:notice] = "Transaction sent successfully"
  	else
      log("send_tx initiated, not enough money")
  		flash[:notice] = "You cannot send more than you have"
  	end
  end

  def withdraw
    log("withdraw loaded")
    conv = Converter.new
    @balance = conv.to_s(calculateBalance(session[:user_id]))
  end

  def withdraw_method
    log("withdraw_method loaded")
    conv = Converter.new
    @balance = conv.to_s(calculateBalance(session[:user_id]))
    @text_area_info = ""
  end

  def put_withdrawal_request
    log("put_withdrawal_request loaded")
    req = WithdrawalRequest.new(requestParams)
    req.userID = session[:user_id]
    # req.information = params[:information]
    req.type = params[:type]
    puts(" >>>> =====")
    puts(req.text_amo)

    conv = Converter.new
    req.amount = conv.to_i(req.text_amo)

    tx = Transaction.new
    tx.to_user = 0
    tx.text_amo = req.text_amo
    tx.from_user = session[:user_id]
    tx.amount = req.amount

    if(tx.amount < 0)
      log("put_withdrawal_request with amount #{tx.amount} tried")
      flash[:notice] = "You cannot withdraw negative amount. You know that :)"
    else 
      if(tx.amount <= calculateBalance(session[:user_id]))
        req.save
      	tx.save
        log("put_withdrawal_request successfully executed")
        flash[:notice] = "Withdrawal process successfully started"
      else
        log("put_withdrawal_request initiated, not enough money")
        flash[:notice] = "You cannot send more than you have"
      end
    end

    

  	redirect_to(:action => 'transactions')
  end



  def deposit
  end

  def transactions
    log("transactions loaded")
    mid = session[:user_id]
    tx_out = Transaction.where(:from_user => mid)
    tx_in =  Transaction.where(:to_user => mid)

    @txes = tx_out
    @txes += tx_in

    @txes.sort_by! do |item| #note the exclamation mark
     		item[:id]
  	end 

  	@txes = @txes.reverse

    balancePreConvert = calculateBalance(session[:user_id])
    conv = Converter.new

  	@balance = conv.to_s(balancePreConvert)

  end

	def calculateBalance(user_id)
		mid = user_id			
      tx_out = Transaction.where(:from_user => mid)
      tx_in =  Transaction.where(:to_user => mid)

      bal = 0

      tx_out.each do |t|
      	bal -= t.amount
      end

	  tx_in.each do |t|
      	bal += t.amount
      end

      return bal
    end

  private
    def txParams
      params.require(:transaction).permit(:from_user, :to_user, :text_amo)
    end

  private
    def requestParams
      params.require(:withdrawal_request).permit(:text_amo, :type, :information)
    end
    
end
