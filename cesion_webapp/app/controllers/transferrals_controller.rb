require 'savon'

class TransferralsController < ApplicationController
  # before_action :set_transferral, only: [:show, :edit, :update, :destroy]

  # GET /transferrals
  # GET /transferrals.json
  def index
    # # create a client for the service
    # #client = Savon.client(wsdl: 'http://localhost:3000/dtews/wsdl')
    # client = Savon.client(wsdl: Rails.configuration.dtews_endpoint)
    # operations = client.operations
    # response = client.call(:get_estado, message: {'consultante' => '***REMOVED***', 'token' => '123123'})
    # response_body = Nokogiri::XML(response.body[:get_estado_response][:value]).xpath('//SII:RESP_BODY').first.content #Assuming that there is only 1 result
    # # We use fragment because we have multiple root nodes. This is not an error, in fact, it's specified that all
    # # nodes are passed as a string on the response, so... Get all transfers for today!
    # aec_fragments = Nokogiri::XML.fragment(response_body).children
    # aec_fragments.select { |aec_doc| aec_doc.xpath("DocumentoAEC/Cesiones/Cesion/DocumentoCesion/TmstCesion").text == '2017-05-19T12:33:22' }
    # # .each do |aec_set|
    # #   ## here each fragment is interpreted as a string of text. so, a direct conversion is not feasible
    # #   ## Note that Nokogiri ignores the root element, so it's needed to search with xpath without the root
    # #   document = aec_set.xpath("DocumentoAEC/Caratula/RutCesionario").to_xml
    # #
    # #   ## Filter by date
    # #
    # #   # @response_body = document
    # # end
    # @result_len = ""#res.length
    # # @response_body = res
    # # @transferrals = Transferral.all
  end

  # GET /transferrals/1
  # GET /transferrals/1.json
  def show
    user = User.find_by_id(params[:id])
    t = Transferrals.new
    token = t.query_token(user.certificate.file.read,user.private_key.file.read)
    t.query_documents(user.rut, token)
    @ctds = Ctd.where('DATE(root_webapp.ctds.transfer_date) = DATE(NOW())')
  end

  def download
    document = Ctd.find_by_id(params[:id])
    filename = document.id.to_s + '.xml'
    send_data(document.doc, :filename => filename)
  end


end
