# Cumplo - Assignment for Junior dev application

## Assignment details
* [Assignment 1 (in Spanish)](OriginalAssignment.MD)
* [Assignment 2 (in Spanish)](SecondAssignment.MD)

## Tracking
After researching the info provided, there was no information on the documentation regarding the credit tranferral operation on the provided site. More over, the web service supposed to be used for that operation wasn't available which led to a change on the assignment.


## Derived requirements
* __SII Credit Transfer Operation__ behaivour __must__ be replicated in order to prove adaptation for both the application stack used on the organization and to the mechanics of the business.

* Any design choices __must__ be documented and explained.

## Design guidelines and asumptions
In this section we'll present all the info related to choicemaking on this project.

### Documentation involved
* [Explanation of Factoring business model (in spanish)](https://chilefactura.wordpress.com/2016/08/25/claves-para-entender-el-factoring)
* [Public Registry of Electronic Transfers - Tech manual](http://www.sii.cl/factura_electronica/ins_tecnico.pdf)
* [Electronic transferral format - Specs](http://www.sii.cl/factura_electronica/cesion.pdf)
* [Electronic transferral format - XML Schema](http://www.sii.cl/factura_electronica/schema_cesion.zip)
* [Electronic transferral format - XML Schema Diagram](http://www.sii.cl/factura_electronica/diagrama_cesion.zip)
* [Code snippet for signing simple XMLs](https://github.com/ebeigarts/signer/blob/01f65278db8852be3f4a28c7f10a2cced966f506/spec/signer_spec.rb#L91-L110)
* [DTE state WS](http://www.sii.cl/factura_electronica/factura_mercado/estado_dte.pdf)

### Findings
* There is no need to request aditional calls to get the DTE data. As it can be read on the documentation, every credit transferral operation must specify the involved document as well as their status.

* There is no information on how the ___Electronic Credit Transferral WebService___ works. After calling to helpdesk they stated that the error that I was recieving were provoked by a non-authorization of the service because I was not a PYME.

* If I were to consume the services in order to retrieve information for _Cumplo.cl_, I need permissions to operate with that business. Those permissions cannot be granted as they compromise business information and management.

* A workaround to the permissions problem is use the devel environment for SII's DTE handling is to go though a process which takes about 4 days to complete:

    1. Create a business and enable "Electronic Tax Document handling" (takes 1 to 2 working days).
    2. Get a digital signature (which costs about 10.000CLP and takes 2 working days to be granted).
    3. Link the certificate with the business and then use the provided web services.

### Asumptions and desicions
* As none of the resources to make a working application are available, I need to develop a working application that replicates the behaivour in order to fullfill the requirements by reverse engineering the target platform using the available documentation.

* A fully working schema does not add any value to this assignment. The only parts that we are really interested are on the understanding of SII's Auth and Transferral and Document Signing procedures. 

* All services on SII are interconnected between them.

* Two applications must be provided as working artifacts. The first one is a emulation layer of SII meant to be as simple as possible to understand but complete enough to reflect the procedures and a client layer to demostrate that the service can be consumed though rails.

* Document signing is a must, as the SII's guidelines specify that all documents must be signed.

* There is no need to implement CRUD operations on certificates, it doesn't add value.

* There is a high posibility for this code to be extended in the future. since the original assignment resources were not validated before being sent, it's a latent posibility the implementation of such features in the future. 

### Normal flow assumed
* __Client__ login on Main Webapp.
* __Webapp__ manages and requests auth credentials from a remote webservice.
* __Webapp__ retrieves credit tranfer data from a remote webservice
* __Client__ browses data

### Auth normal flow
1. Client requests a token (randomly generated on WS).
2. Client signs the token and sends it back to WS.
3. If everything went OK, then an API KEY is returned, which is used to ensure auth against other services.

## Available assets
* A [___document transferral sample___](cesion_webservice/app/assets/schemas/schema_cesion/AEC.example.xml) derived from XSD definitions provided by SII to be used as a starting template in case of addning new credit transfers.

## Messy things
* **Nokogiri:** It was a pain to make it work. Specially with pretty print issues which messed up my XML format everytime. It took me several hours to understand it's behaivour. Also, there is a huge difference in ```node.replace(signer.document.root)``` and ```node.replace(signer.document.to_xml)```

* I messed up the implementation ([dev reaction at 5AM when realizing the mistake](reaction.jpg)). You can check the details [here](WhatHappenedAtThisPoint.MD).

## Result
* Just implemented the bare minimum requirements.

## How to make it work
* There is a user mantainer at webapp, on `/users` route. you need to create a user in order to query the webservice. It's not actually used at all by web service as it creates fake replies.
* Then you go to `/transferrals` where you can start playing with the documents

## Why that model? (CTD - CreditTransferDocument)
Only the relevant models are included on the model, as those are the only ones used to fast-identify which document is needed.

* **source:** Business name of the sender
* **source_rut:** Rut of the sender
* **destination:**  Business name of the target taxpayer
* **destination_rut:** Business name of the target taxpayer
* **transfer_date:** Most important field, as it's used to identify if the document has to be shown or not (everytime that user reloads transferral controller, it populates with new elements, which are expected to be filtered)
* **folio:** Folio number
* **amount:** Self explanatory -> $$$
* **state:** If it was transfered or not.
* **document:** The actual DTE