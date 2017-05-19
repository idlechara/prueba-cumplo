# Cumplo - Assignment for Junior dev application

## Design guidelines and asumptions
* It is required to imitate as close as possible the behaivour of SII when treating authentication and cesion retrival.
* Cesion services must be isolated as applications from Auth services.
* As there is no restriction about databases, a single database is used for sake of simplicity.

## Normal flow assumed
* Client login on Main Webapp.
* Webapp request auth credentials from a remote webservice.
* Webapp retrieves data from a remote webservice
* Client browses and filter data

## Webservice "Auth"
Implements autentification for the webservice. For now the whole XML Schema is not replicated, but it's behaivour is preserved. 

### Normal flow
1. Client requests a token (randomly generated on WS).
2. Client signs the token and sends it back to WS.
3. If everything went OK, then an API KEY is returned, which is used to ensure auth against other services.



## Webservice "Cesion"
Implements document transferral from one taxpayer to another. The schema documentation doesn't specify where the transferral info is held, so we'll only return random generated data from it.

## Webservice "Cesion"
Implements document transferral from one taxpayer to another.