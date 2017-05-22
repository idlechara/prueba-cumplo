# Rebuild of ~~evangelion~~ entry project
**Rationale:** While reparing the project I made a ton of design mistakes. So, I'll try to fix them tonight. (22 May 2017)

## Improvements
* **Removed all wrong stuff:** All my previous project.
* **rake db:seed** (with multi-threading)
* **Simplified model**
* **Active crawler** (yes, it retrieves the info from SII without a webservice).
* **docker-compose** because it simplifies things when deploying (and personally, I'm a big fan on containerization technology).


As a sidenote, it takes ***A WHILE*** to set up the project, so if you run it, please be patient.

## User's manual
* I'm sure that you'll understand the application as soon as you enter on it. It's on my domain, [prueba.mimashita.moe](prueba.mimashita.moe).

## Considerations
* By default we don't know the transferral timestamp. So...
    * The only documents with transferral timestamps are the seeded ones.
    * If you add a new document using the interface, then it will be timestamped with today's date. This means that tomorrow you'll be not able to see it
    


## Things that I'll be glad to have
* Some coffee and a Redbull to endure today's debate at elections
* If I were to know [some extra fields](images/extra_data.png) like ***issuing date*** I can probably add extra info like DTE's details. I haven't tested it since I don't have any electronic document info at hand.

## What happened to your previous idea, the one with the webservices and all that WSDL hell?
You can check my previous commits. It's still there, but I don't feel like just linking it. The rationale to change the implementation is that I prefer to deliver something that works. This version CAN grab the information from SII without even being an authorized taxpayer.

The previous version aimed more to prove that I can simulate most aspects of SII behaivour, but I didn't counted with some malformed XMLs, the lack of documentation (about a failing service) and that I would be studying for my Networking examfor about two days.

## Ok, I want to test this thing. What do I need?
First of all you need to configure some fields on [docker-compose.yaml](docker-compose.yaml) file. It's pretty straightforward.