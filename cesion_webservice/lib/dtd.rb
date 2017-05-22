require 'nokogiri'
require 'signer'

class Dtd
  @document = nil
  @@cert_path = '/Volumes/Yakumo/Documents/Sources/2017/cumplo/prueba/cesion_webservice/app/assets/keys/server.crt'
  @@key_path = '/Volumes/Yakumo/Documents/Sources/2017/cumplo/prueba/cesion_webservice/app/assets/keys/server.key'
  @@base_transfer_document = 'app/assets/schemas/schema_cesion/AEC.example.xml'

  # Generates a random Cesion file with "random" parameters
  def initialize(value, emit_date, transfer_date, deadline_tmst, valid, folio)
    # Use default document at cesion_webservice/app/assets/schemas/schema_cesion/AEC.example.xml
    document = Nokogiri::XML(File.read(@@base_transfer_document))

    # Alter default values
    document.xpath('//FchEmis').each do |tmst|
      tmst.content = emit_date
    end
    document.xpath('//TmstCesion').each do |tmst|
      tmst.content = transfer_date
    end
    document.xpath('//UltimoVencimiento').each do |tmst|
      tmst.content = deadline_tmst
    end
    document.xpath('//MontoCesion').each do |amount|
      amount.content = value
    end
    document.xpath('//MntTotal').each do |amount|
      amount.content = value
    end

    document.xpath('//Folio').each_with_index  do |folio_val, idx|
      folio_val.content = folio
    end

    document.xpath('//EstadoCesion').each do |state|
      if valid
        state.content = "Cedido"
      else
        state.content = "No Cedido"
      end
    end

    # ## Every signature is broken.
    # ## Now, sign every part of the DTE that NEEDS to be signed.
    # sign_xml_fragment(document, '//DocumentoDTECedido/DTE' ,File.read(@@cert_path), File.read(@@key_path))
    # sign_xml_fragment(document, '//DocumentoDTECedido' ,File.read(@@cert_path), File.read(@@key_path))
    # sign_xml_fragment(document, '//Cesiones/Cesion/DocumentoCesion' ,File.read(@@cert_path), File.read(@@key_path))
    # sign_xml_fragment(document, '//DocumentoAEC' ,File.read(@@cert_path), File.read(@@key_path))
    #

    @document = document
  end

  ## Routine to sign a fragment of the XML.
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

  def document
    return @document
  end
end