require 'securerandom'

class DtewsController < ApplicationController
  soap_service namespace: 'cumplo:prueba'


  soap_action "getSeed",
              :return => :string
  def getSeed
    # Create random shit
    # Store on db
    # render
    generated_seed = SecureRandom.urlsafe_base64(10)
    token = AuthToken.new
    token.seed = generated_seed
    token.save()

    ## Build document structure
    document = Nokogiri::XML <<-XML
    <SII:RESPUESTA xmlns:SII="http://www.sii.cl/XMLSchema">
      <SII:RESP_HDR>
        <ESTADO></ESTADO>
      </SII:RESP_HDR>
      <SII:RESP_BODY>
        <SEMILLA></SEMILLA>
      </SII:RESP_BODY>
    </SII:RESPUESTA>
    XML

    ## Edit data
    state = document.at_xpath "SII:RESPUESTA/SII:RESP_HDR/ESTADO"
    state.content = "00" # 00 because we always generate a seed... As long it works...
    seed = document.at_xpath "SII:RESPUESTA/SII:RESP_BODY/SEMILLA"
    seed.content = generated_seed # previously generated
    render soap: document.to_xml
  end



  soap_action "getToken",
              args: {:pszXml => :string},
              return: :string
  def getToken
    ## perform some validations over the parameters here
    generated_token = SecureRandom.urlsafe_base64(20)

    puts("\n\n"+params.inspect+"\n\n")

    if params[:pszXml].nil?
      document_state = { :state => '08', :details => 'PARAMETROS INCORRECTOS"', :token => "" }
      valid_query = false

    # ##Add condition for timeout on server
    # elsif params[:psxXml].nil?
    #   document_state = { :state => '01', :details => 'Token no especificado', :token => "" }
    #   valid_query = false

    else
      ## Check signature
      puts("\n\n"+params[:pszXml]+"\n\n")
      ## Generate seed if everything goes OK
      document_state = { :state => '00', :details => 'Token creado', :token => generated_token }
    end

    ## Build document structure
    document = Nokogiri::XML <<-XML
    <SII:RESPUESTA xmlns:SII="http://www.sii.cl/XMLSchema">
      <SII:RESP_HDR>
        <ESTADO></ESTADO>
        <GLOSA></GLOSA>
      </SII:RESP_HDR>
      <SII:RESP_BODY>
        <TOKEN></TOKEN>
      </SII:RESP_BODY>
    </SII:RESPUESTA>
    XML

    ## Edit data
    state = document.at_xpath "SII:RESPUESTA/SII:RESP_HDR/ESTADO"
    state.content = document_state[:state]
    details = document.at_xpath "SII:RESPUESTA/SII:RESP_HDR/GLOSA"
    details.content = document_state[:details]
    token = document.at_xpath "SII:RESPUESTA/SII:RESP_BODY/TOKEN"
    token.content = document_state[:token]

    render soap: document
  end



  # Returns all document transferrals for a given consultant
  soap_action "getEstado",
              args: { :consultante => :string, :token => :string },
              return: :string
  def getEstado
    ## perform some validations over the parameters here
    generated_token = SecureRandom.urlsafe_base64(20)
    valid_query = true

    if params[:consultante].nil?
      document_state = { :state => '01', :details => 'Consultante no especificado' }
      valid_query = false

    elsif params[:token].nil?
      document_state = { :state => '01', :details => 'Token no especificado' }
      valid_query = false

    else
      document_state = { :state => '00', :details => 'Entregado' }
    end

    puts("\n\n" + params.inspect + "\n\n")

    ## Build document structure... this one is ficticious, as we don't actually expect documents to be generated in this way
    document = Nokogiri::XML <<-XML
    <SII:RESPUESTA xmlns:SII="http://www.sii.cl/XMLSchema">
      <SII:RESP_HDR>
        <ESTADO></ESTADO>
        <GLOSA></GLOSA>
      </SII:RESP_HDR>
      <SII:RESP_BODY>
      </SII:RESP_BODY>
    </SII:RESPUESTA>
    XML

    ## Edit base response data
    state = document.at_xpath "SII:RESPUESTA/SII:RESP_HDR/ESTADO"
    state.content = document_state[:state]
    details = document.at_xpath "SII:RESPUESTA/SII:RESP_HDR/GLOSA"
    details.content = document_state[:details]

    if valid_query
      resp_text = ""

      # generate random data for before a certain date
      (1.. 10).each() do |i|
        d = Dtd.new(1000,
                    '2017-05-19T09:33:22',
                    '2017-05-19T12:33:22',
                    '2017-05-30T09:33:22').document.at('AEC')
        resp_text += d.to_xml
      end

      # generate random data for today
      (1.. 10).each() do |i|
        d = Dtd.new(1000,
                    '2017-05-20T09:33:22',
                    '2017-05-20T12:33:22',
                    '2017-05-30T09:33:22').document.at('AEC')
        resp_text += d.to_xml
      end

      resp_body = document.xpath("SII:RESPUESTA/SII:RESP_BODY").first
      resp_body.content = resp_text
    end
    render soap: document
  end
end
