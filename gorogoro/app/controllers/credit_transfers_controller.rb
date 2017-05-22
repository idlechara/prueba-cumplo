class CreditTransfersController < ApplicationController
  before_action :set_credit_transfer, only: [:show, :edit, :update, :destroy]

  def index
    # @credit_transfers = CreditTransfer.all
    @ctds_valid = Ctd.where("DATE(transfer_timestamp) = DATE(?) AND status = ?", Time.now.strftime("%Y-%m-%d"),  'Cedido')

    @ctds_invalid = Ctd.where("DATE(transfer_timestamp) = DATE(?) AND status = ?", Time.now.strftime("%Y-%m-%d"),  'No Cedido')

    @ctds_unkown = Ctd.where("DATE(transfer_timestamp) = DATE(?) AND status = ?", Time.now.strftime("%Y-%m-%d"),  'Desconocido')
  end

  def new
  end

  def create
    @credit_transfer = Ctd.new()
    @credit_transfer.folio = params[:folio]
    if Taxpayer.find_by_rut(params[:rut_sender].gsub(".",'')).nil?
      respond_to do |format|
        format.any { render :json => {:response => 'Rut del cedente no es un contribuyente' },:status => 418  }
      end
      return
    end
    if Taxpayer.find_by_rut(params[:rut_recipient].gsub(".",'')).nil?
      respond_to do |format|
        format.any { render :json => {:response => 'Rut del cesionario no es un contribuyente' },:status => 418  }
      end
      return
    end
    @credit_transfer.sender = Taxpayer.find_by_rut(params[:rut_sender].gsub(".",''))
    @credit_transfer.recipient = Taxpayer.find_by_rut(params[:rut_recipient].gsub(".",''))
    @credit_transfer.amount = params[:amount]
    @credit_transfer.transfer_timestamp = Time.parse(params[:date])
    @credit_transfer.save
    @credit_transfer.validate_document!

    redirect_to :controller => 'credit_transfers', :action => 'index'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_credit_transfer
      @credit_transfer = CreditTransfer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def credit_transfer_params
      params.fetch(:credit_transfer, {})
    end
end
