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

## Gems Used in Alphabetical Order 
* [Bcrypt:](https://rubygems.org/gems/bcrypt/versions/3.1.11) Bcrypt is used hashing or encrypting sensitive user data
* [Dotenv:](https://github.com/bkeepers/dotenv) Shim to load environment variables from .env into ENV in development.
* [Pg:](https://rubygems.org/gems/pg/versions/0.18.4) Pg is the Ruby interface to the {PostgreSQL RDBMS}[http://www.postgresql.org/]
* [Sass:](https://github.com/sass/ruby-sass)  Sass is an extension of CSS, adding nested rules, variables, mixins,selector inheritance, and more. It's translated to well-formatted, standard CSS using the command line tool or a web-framework plugin.
* [Sinatra Activerecord:](https://github.com/janko-m/sinatra-activerecord) Extends [Sinatra](http://www.sinatrarb.com/) with extension methods and Rake
tasks for dealing with an SQL database using the
[ActiveRecord ORM](https://github.com/rails/rails/tree/master/activerecord).
* [Time Diff:](https://rubygems.org/gems/time_diff) Gem which calculates the difference between two time.
* [Sysrandom:](https://github.com/cryptosphere/sysrandom) Secure random number generation for Ruby using system RNG facilities e.g. /dev/urandom, getrandom(2)

## Installation
- Clone this repository to have the app on your machine with ```git clone https://github.com/mikey2020/micro-learning-app.git```
- Change directory to the app's root with ```cd micro-learning-app```
- Pull the development branch with ```git pull origin develop```
- Then run ```bundle install```  to install the dependencies.
- Run ```rake db:migrate``` to migrate database tables.
- Run ```rake db:seed``` to seed database tables.
- Start the server with ```ruby app.rb```
- Then visit ```http://localhost:4567``` to view the app.
- To use admin feature please login with username as `admin` and password as `admin123`.

It is hosted on heroku at <a href="https://micro-learning.herokuapp.com/" target="_blank">SMLA</a>.

## Limitations
- You cannot see previous pages except the page for the day.

## User functions
- As a user you can sign up and view a new page for each day

## Admin functions
- As an admin you can delete a user 

## How to Contribute
- Fork this repository.
- Clone it.
- Create your feature branch on your local machine with ```git checkout -b your-feature-branch```
- Push your changes to your remote branch with ```git push origin your-feature-branch```
- Open a pull request to the master branch, and describe how your feature works

### Author
Michael Eboagu