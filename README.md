# Lufthouse-CMS

## Rails version
4.1.1

## System dependencies

## Configuration

## Database
The application expects to run against Postgres.

## Application and User Setup

To start the application run `bundle install`, then `rake db:migrate`, and `rails s`. your application will be available at [http://localhost:3000/](http://localhost:3000/)

You will then be able to access the admin console at [http://localhost:3000/admin](http://localhost:3000/admin). You will have to log in using the default admin user with `username: admin@example.com` and `password: password`.

I installed the devise gem which does User management for us so we can change this default admin user before the website gets posted up on Heroku.


User: people logging onto site
Customer: company that users are part of