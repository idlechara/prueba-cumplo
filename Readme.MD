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

## What happened to your previous idea?
You can check my previous commits. It's still there, but I don't feel like just linking it