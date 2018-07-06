# Super Micro Learning Application

SMLA is a responsive web application that sends you one page per day about something you want to learn. Could be: a new Language, a random Wikipedia page, React documentation, a page from the CIA World Factbook, anything! 

## Development
This app was developed using ruby sinatra, with erb as template.

## Technologies Used
* [Ruby:](https://www.ruby-lang.org/en/) Ruby is a dynamic, open source programming language with a focus on simplicity and productivity. It has an elegant syntax that is natural to read and easy to write.
* [Sinatra:](http://sinatrarb.com//)
* [Erb:](https://en.wikipedia.org/wiki/ERuby) Embedded Ruby is a templating system that embeds Ruby into a text document. It is often used to embed Ruby code in an HTML document, similar to ASP, JSP and PHP
* [PostgreSQL:](https://www.postgresql.org/) PostgreSQL is a powerful, open source object-relational database system (ORDBMS) that offers modern database features such as complex queries, foreign keys, etc.
* [NewsApi:](https://newsapi.org/) News API is a simple HTTP REST API for searching and retrieving live articles from all over the web

## Installation
- Clone this repository to have the app on your machine with ```git clone https://github.com/mikey2020/micro-learning-app.git```
- Change directory to the app's root with ```cd micro-learning-app```
- Pull the development branch with ```git pull origin develop```
- Then run ```bundle install```  to install the dependencies
- Start the server with ```ruby app.rb```
- Then visit ```http://localhost:4567``` to view the app.

It is hosted on heroku at <a href="https://micro-learning.herokuapp.com/" target="_blank">ChopChop</a>.

## Limitations
- You cannot see previous pages except the page for the day.

## How to Contribute
- Fork this repository.
- Clone it.
- Create your feature branch on your local machine with ```git checkout -b your-feature-branch```
- Push your changes to your remote branch with ```git push origin your-feature-branch```
- Open a pull request to the master branch, and describe how your feature works

### Author
Michael Eboagu