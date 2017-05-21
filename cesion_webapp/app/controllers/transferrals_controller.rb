require 'savon'

class TransferralsController < ApplicationController
  before_action :set_transferral, only: [:show, :edit, :update, :destroy]

  # GET /transferrals
  # GET /transferrals.json
  def index
    # create a client for the service
    #client = Savon.client(wsdl: 'http://localhost:3000/dtews/wsdl')
    client = Savon.client(wsdl: Rails.configuration.dtews_endpoint)
    operations = client.operations
    response = client.call(:get_estado, message: {'consultante' => '***REMOVED***', 'token' => '123123'})
    response_body = Nokogiri::XML(response.body[:get_estado_response][:value]).xpath('//SII:RESP_BODY').first.content #Assuming that there is only 1 result

    # We use fragment because we have multiple root nodes. This is not an error, in fact, it's specified that all
    # nodes are passed as a string on the response, so... Get all transfers for today!
    aec_fragments = Nokogiri::XML.fragment(response_body).children
    aec_fragments.select { |aec_doc| aec_doc.xpath("DocumentoAEC/Cesiones/Cesion/DocumentoCesion/TmstCesion").text == '2017-05-19T12:33:22' }
    # .each do |aec_set|
    #   ## here each fragment is interpreted as a string of text. so, a direct conversion is not feasible
    #   ## Note that Nokogiri ignores the root element, so it's needed to search with xpath without the root
    #   document = aec_set.xpath("DocumentoAEC/Caratula/RutCesionario").to_xml
    #
    #   ## Filter by date
    #
    #   # @response_body = document
    # end
    @result_len = ""#res.length
    # @response_body = res



    # @transferrals = Transferral.all
  end

  # GET /transferrals/1
  # GET /transferrals/1.json
  def show
  end

  # GET /transferrals/new
  def new
    @transferral = Transferral.new
  end

  # GET /transferrals/1/edit
  def edit
  end

  # POST /transferrals
  # POST /transferrals.json
  def create
    @transferral = Transferral.new(transferral_params)

    respond_to do |format|
      if @transferral.save
        format.html { redirect_to @transferral, notice: 'Transferral was successfully created.' }
        format.json { render :show, status: :created, location: @transferral }
      else
        format.html { render :new }
        format.json { render json: @transferral.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transferrals/1
  # PATCH/PUT /transferrals/1.json
  def update
    respond_to do |format|
      if @transferral.update(transferral_params)
        format.html { redirect_to @transferral, notice: 'Transferral was successfully updated.' }
        format.json { render :show, status: :ok, location: @transferral }
      else
        format.html { render :edit }
        format.json { render json: @transferral.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transferrals/1
  # DELETE /transferrals/1.json
  def destroy
    @transferral.destroy
    respond_to do |format|
      format.html { redirect_to transferrals_url, notice: 'Transferral was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transferral
      @transferral = Transferral.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transferral_params
      params.fetch(:transferral, {})
    end
end
