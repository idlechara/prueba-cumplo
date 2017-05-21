require 'xmldsig'

unsigned_document = Nokogiri::XML <<-XML
<AEC xmlns:ds="http://www.w3.org/2000/09/xmldsig#" xmlns:ec="http://www.w3.org/2001/10/xml-exc-c14n#">
  <DocumentoAEC ID="">
    <!-- Información sobre la cual filtrar la búsqueda-->
    <Caratula version="1.0">
      <RutCedente>76.273.545-8</RutCedente>
      <RutCesionario>76.177.621-5</RutCesionario>
      <!--<TmstFirmaEnvio>2017-05-19T09:33:22</TmstFirmaEnvio>-->
    </Caratula>
    <Cesiones>
      <DTECedido version="1.0">
        <DocumentoDTECedido ID="___">
          <DTE version="1.0">
            <Documento ID="__">
              <Encabezado>
                <IdDoc>
                  <TipoDTE>33</TipoDTE>
                  <Folio>027</Folio>
                  <FchEmis>2017-05-19T09:33:22</FchEmis>
                </IdDoc>
                <Emisor>
                  <RUTEmisor>76.273.545-8</RUTEmisor>
                  <RznSoc>EBCO LINEAS SPA</RznSoc>
                </Emisor>
                <Receptor>
                  <RUTRecep>17.542.034-7</RUTRecep>
                  <RznSocRecep>Erik Regla</RznSocRecep>
                </Receptor>
                <Totales>
                  <MntTotal>2122960</MntTotal>
                </Totales>
              </Encabezado>
              <!-- Los otros campos no son requeridos -->
              <!--<TmstFirma></TmstFirma>-->
            </Documento>
          </DTE>
          <!--<TmstFirma></TmstFirma>-->
        </DocumentoDTECedido>
      </DTECedido>
      <Cesion version="1.0">
        <DocumentoCesion ID="_">
          <!-- Correlativo. Debe ser incrementado de 1 en 1, partiendo de 1 -->
          <SeqCesion>1</SeqCesion>
          <IdDTE>
            <TipoDTE>33</TipoDTE>
            <RUTEmisor>76.273.545-8</RUTEmisor>
            <RUTReceptor>17.542.034-7</RUTReceptor>
            <Folio>027</Folio>
            <FchEmis>2017-05-19T09:33:22</FchEmis>
            <MntTotal>2122960</MntTotal>
          </IdDTE>
          <Cedente>
            <RUT>76.273.545-8</RUT>
            <RazonSocial>EBCO LINEAS SPA</RazonSocial>
            <Direccion></Direccion>
            <eMail></eMail>
            <RUTAutorizado>
              <RUT>76.273.545-8</RUT>
              <Nombre>EBCO LINEAS SPA</Nombre>
            </RUTAutorizado>
          </Cedente>
          <Cesionario>
            <RUT>76.177.621-5</RUT>
            <RazonSocial>CUMPLO CHILE S.A</RazonSocial>
            <Direccion></Direccion>
            <eMail></eMail>
          </Cesionario>
          <MontoCesion>2122960</MontoCesion>
          <UltimoVencimiento>2017-05-30T09:33:22</UltimoVencimiento>
          <TmstCesion>2017-05-19T12:33:22</TmstCesion>
        </DocumentoCesion>
      </Cesion>
    </Cesiones>
  </DocumentoAEC>
  <ds:Signature>
    <ds:SignedInfo>
      <ds:CanonicalizationMethod Algorithm="http://www.w3.org/2001/10/xml-exc-c14n#"/>
      <ds:SignatureMethod Algorithm="http://www.w3.org/2001/04/xmldsig-more#rsa-sha256"/>
      <ds:Reference URI="">
        <ds:Transforms>
          <ds:Transform Algorithm="http://www.w3.org/2000/09/xmldsig#enveloped-signature"/>
          <ds:Transform Algorithm="http://www.w3.org/2001/10/xml-exc-c14n#">
            <ec:InclusiveNamespaces PrefixList="#default"/>
          </ds:Transform>
        </ds:Transforms>
        <ds:DigestMethod Algorithm="http://www.w3.org/2001/04/xmlenc#sha256"/>
        <ds:DigestValue></ds:DigestValue>
      </ds:Reference>
    </ds:SignedInfo>
    <ds:SignatureValue></ds:SignatureValue>
  </ds:Signature>
</AEC>
XML

private_key = OpenSSL::PKey::RSA.new(File.read("server.key"))
certificate = OpenSSL::X509::Certificate.new(File.read("server.crt"))
puts unsigned_document.class
document = Nokogiri::XML(unsigned_document)
puts(document)

# unsigned_document = Xmldsig::SignedDocument.new(document)
#signed_xml = unsigned_document.sign(private_key)
