# Lufthouse-CMS
<a href="https://codeclimate.com/github/joanieS/CMS"><img src="https://codeclimate.com/github/joanieS/CMS/badges/gpa.svg" /></a>

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

## Devise

Users are authenticated using the Devise gem.

## Paperclip

The Paperclip gem is used to handle content images. Had to downgrade to version 3.5.4 to prevent failure to store images due to spoofing.

## Gmaps4rails

Instead of specifying an accompanying cardinal direction when defining latitude and longitude, this application uses negative values to define latitudes south of the equator and longitudes west of the Greenwich meridian. As such, the coordinates have the following accepted range (in degrees):

* Latitude [-90,90]
* Longitude [-180,180]

## AWS S3

All beacon images are stored remotely in AWS S3.

### Beacon UUID

Beacon UUID is currently automatically set. Change this generic value in the beacon edit page.
