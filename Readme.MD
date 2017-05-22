# Rebuild of ~~evangelion~~ entry project
**Rationale:** While reparing the project I made a ton of design mistakes. So, I'll try to fix them tonight. (22 May 2017)

## Improvements
### Removed all wrong stuff from the former project
It has tons of flaws from the design PoV. Many non-understandable code, a non-intuitive interface, hard to explain code... It's not good.

### Rake db:seed... With bonuses
Now db:seed takes a loooong time, but it's because at the first run it crawls all taxpayer information from the public registries. This allows to identify RUTs by getting their business name when storing them on the database. It's better to take advantage of this and make a 1:N relationship between Taxpayers and trackeable Documents.

### Simplified model
There is no need to store users as all info can be gathered without the use of public certificates and all that messy stuff. Thanks open-data!

### Selenium-powered crawler
The public info is only avaliable by browsing the site, for this reason a *Selenium Webdriver*-powered crawler renders the page and simulates real user interaction in order to grab the information from the user portal on SII. 

### Docker
You can treat this application as a part of a bigger structure. It also helps to ease setup and deploy times by centralizing all configurations on a single docker-compose configuration. There is also a base image for this application in order to speedup building time. (Disclaimer: I love docker <3)

## User's manual
I'm sure that you'll understand the application as soon as you enter on my domain, [prueba.mimashita.moe](prueba.mimashita.moe). The interface is simplier in order to go straightforward to the current day documents. Filters are implemented as sections as there is no damage in doing it and speeds up reading. For such small files with so little info (and also considerating the layout aesthetics) there is no need to filter them. 

### Considerations
* By default we don't know the transferral timestamp. So...
    * The only documents with transferral timestamps are the seeded ones.
    * If you add a new document using the interface, then it will be timestamped with today's date. This means that tomorrow you'll be not able to see it
    


## Things that I'll be glad to have (but I need some more info to improve them)
* ~~Some coffee and a Redbull to endure today's debate at elections~~ Not needed, everything went perfect.
* If I were to know [some extra fields](images/extra_data.png) like ***issuing date*** I can probably add extra info like DTE's details. I haven't tested it since I don't have any electronic document info at hand.

## What happened to your previous idea, the one with the webservices and all that WSDL hell?

Goals of the first idea:
* Demostrate that I can adapt to a weird environment
* Learn Rails
* Learn to deal with SII strange messaging standards

The problem with it, it is that it doesn't solved the original problem, to check validations of documents. Also, I was too focused on trying to make something perfect that I forgot about making it work in first place.

Goals of this version:
* K.I.S.S.
* Smaller and more structured code. Helps understanding
* Simplier UI. I readed a bit about material design guidelines on the morning and it really helps. No extra help needed for its use.
* And more importantly **IT SOLVES THE ORIGINAL PROBLEM, TO GRAB REAL INFORMATION ABOUT TRANSFERRALS**


Personally I prefer a simple, elegant and easy to understand solution that works. *Done is better than perfect.*

## Ok, I want to test this thing. What do I need?
It depends on your masochism levels:

### Yes! I'm a masochist!
* Install Ruby.
* Install Rails, any version ≥ 5 will do.
* Then, do `bundle install`on `webapp` directory
* You'll need to install a ***Standalone Selenium Chrome-Webdriver*** somewhere on your machine and expose it on the port 4444. [Selenium download page](http://www.seleniumhq.org/download/)
* Set-up your `SII_USERNAME` and `SII_PASSWORD` environment variables
* Install and ready an instance of MySQL. Remember to adjust Rails's db configuration to match your needs.
* Perform migrations, setup and seeding of databases on Rails by issuing rake commands.
* Run rails server on /webapp.
* Pray5**succ**ess.

### I have normal tastes.
* Install docker and docker-compose. 
* Adjust variables on `docker-compose.yaml` file as you see fit.
* Run the following commands
```sh
docker build . # to create ruby image
docker-compose create # create container instance
docker-compose up -d # bring all online
```
Enjoy some popcorn while docker-compose does everything for you. Grabbing all taxpayers info and seeding will take some time, like 30 minutes so yeah, go buy some popcorn.

## Just for the record
* **Rebuild start time:** May 22 00:43 CLT
* **Rebuild end time:** May 22 08:33 CLT
* **Mounting application, fixing proxies and dealing with DNSs:** May 22 09:40 CLT to May 22 18:10 CLT 

Lesson learned, don't mess with your DNS server.