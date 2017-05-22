require 'savon'
require 'xmldsig'
class Transferrals

  ## Get all documents and store them on a database. Later we can query them.
  def query_documents(consultante, token)
    # create a client for the service
    # client = Savon.client(wsdl: 'http://localhost:3000/dtews/wsdl')
    client = Savon.client(wsdl: Rails.configuration.dtews_endpoint)
    response = client.call(:get_estado, message: {'consultante' => consultante, 'token' => token})
    response_body = Nokogiri::XML(response.body[:get_estado_response][:value]).xpath('//SII:RESP_BODY').first.content #Assuming that there is only 1 result

    # We use fragment because we have multiple root nodes. This is not an error, in fact, it's specified that all
    # nodes are passed as a string on the response, so... Get all transfers for today!
    aec_fragments = Nokogiri::XML.fragment(response_body).children
    aec_fragments.each do |aec_doc|
      doc = Ctd.new
      doc.folio = aec_doc.at("Folio").content
      doc.amount = aec_doc.at("MontoCesion").content
      doc.source = aec_doc.at("Cedente/RazonSocial").content
      doc.source_rut = aec_doc.at("Cedente/RUT").content
      doc.destination = aec_doc.at("Cesionario/RazonSocial").content
      doc.destination_rut = aec_doc.at("Cesionario/RUT").content
      doc.transfer_date = Time.parse(aec_doc.at("TmstCesion").content)
      doc.state = aec_doc.at("EstadoCesion").content
      doc.doc = aec_doc.to_xml
      doc.save
    end
  end

  def query_seed
    # create a client for the service
    client = Savon.client(wsdl: Rails.configuration.dtews_endpoint)
    response = client.call(:get_seed)
    response_body = Nokogiri::XML(response.body[:get_seed_response][:value]).xpath('//SII:RESP_BODY').first.content.strip #Assuming that there is only 1 result
    response_body
  end

  def query_token(cert="", key="")
    seed = Nokogiri::XML <<-XML
      <?xml version="1.0"?>
      <getToken>
      <item>
       <Semilla>10</Semilla>
      </item>
      </getToken>
    XML
    # sign_xml_fragment(seed, '//getToken' ,cert, key)

    client = Savon.client(wsdl: Rails.configuration.dtews_endpoint)
    response = client.call(:get_token, message: {'pszXml' => seed.to_xml})
    response_body = Nokogiri::XML(response.body[:get_token_response][:value]).xpath('//SII:RESP_BODY').first.content.strip #Assuming that there is only 1 result
    response_body
  end


  ## Routine to sign a fragment of the XML.
  ## I still don't understand how to make shared libraries among projects. So, this code is repeated from the other project
  ## Feature broken, I meesed up the signing implementation
  def sign_xml_fragment(document, path, cert, key)
    document.xpath(path).each do |node|
      signer = Signer.new(node)
      signer.cert = OpenSSL::X509::Certificate.new(cert)
      signer.private_key = OpenSSL::PKey::RSA.new(key)
      signer.security_node = signer.document.root
      signer.security_token_id = ""
      signer.digest!(signer.document.root, :id => "")
      signer.sign!(:issuer_serial => true)
      node.replace(signer.document.root)
    end
  end
end

