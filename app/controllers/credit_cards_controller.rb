class CreditCardsController < ApplicationController
  before_action :move_to_root
  before_action :set_card, only: [:new, :show, :destroy, :buy, :pay ]
  before_action :set_item, only: [:buy, :pay]

  require "payjp"

  def new
    if @card.present?
      redirect_to credit_card_path(current_user.id)
    else
      card = CreditCard.where(user_id: current_user.id)
    end
  end

  def create
    Payjp.api_key = Rails.application.credentials[:PAYJP_SECRET_KEY]
    if params['payjp-token'].blank?
      redirect_to action: :new
    else
      customer = Payjp::Customer.create(
        card: params['payjp-token'],
        metadata: {user_id: current_user.id},
        description: 'test'
      )
      @card = CreditCard.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to regist_done_credit_cards_path
      else
        redirect_to action: :new
      end
    end
  end

  def regist_done
  end

  def show
    if @card.blank?
      redirect_to action: :new
    else
      Payjp.api_key = Rails.application.credentials[:PAYJP_SECRET_KEY]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @card_info = customer.cards.retrieve(@card.card_id)
      case @card_info.brand
        when "Visa"
          @card_src = "logo_visa_ph001.png"
        when "JCB"
          @card_src = "jcb-logomark-img-01.gif"
        when "MasterCard"
          @card_src = "mc_vrt_pos.svg"
        when "American Express"
          @card_src = "amex-logomark-img-04.gif"
        when "Diners Club"
          @card_src = "diners-logomark-img-01.gif"
      end
    end
  end


def buy
  card = CreditCard.where(user_id: current_user.id).first
  if @card.blank?
    redirect_to action: :new
  else
    Payjp.api_key = Rails.application.credentials[:PAYJP_SECRET_KEY]  
    customer = Payjp::Customer.retrieve(@card.customer_id)
    @card_info = customer.cards.retrieve(@card.card_id)
    case @card_info.brand
      when "Visa"
        @card_src = "logo_visa_ph001.png"
      when "JCB"
        @card_src = "jcb-logomark-img-01.gif"
      when "MasterCard"
        @card_src = "mc_vrt_pos.svg"
      when "American Express"
        @card_src = "amex-logomark-img-04.gif"
      when "Diners Club"
        @card_src = "diners-logomark-img-01.gif"
    end
  end
end

def pay
  Payjp.api_key = Rails.application.credentials[:PAYJP_SECRET_KEY]
  customer = Payjp::Customer.retrieve(@card.customer_id)
  Payjp::Charge.create(
    amount: @item.price,
    customer: customer,
    currency: 'jpy'
  )
  @item.update!(trading_status: "売却済")
end



  def destroy
    if @card.blank?
    else
      Payjp.api_key = Rails.application.credentials[:PAYJP_SECRET_KEY]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      customer.delete
      @card.delete
    end
      redirect_to delete_done_credit_cards_path
  end

  def delete_done
  end

  private

  def move_to_root
    redirect_to root_path unless user_signed_in?
  end

  def set_card
    @card = CreditCard.find_by(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

end
