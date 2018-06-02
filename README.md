# RepCheck

* Users can find their congressional district by clicking on their location on a map or  entering their address. Currently this app is only built with Colorado data. Users are redirected to a profile page for their Congressional representative. The representative's contact info, recent tweets, and voting summary are listed here. Users can see how often their representative voted differently than their party - and on what types of issues. If there are particular reps that a user wants to keep an eye on, a logged in user can add reps to their favorites list to easily find them again.
* The deployed version can be found here: [RepCheck](https://rep-check.herokuapp.com/)
* The spec for this project can be found here: [Project Spec](http://backend.turing.io/module3/projects/self_directed_project)

## Getting Started

To run this application locally for testing and development, clone this repo and follow the steps below:

Bundle:
`$ bundle`

Set up the database:
`$ rake db:create`
`$ rake db:migrate`
`$ rake db:seed`

Now go grab a coffee because seeding takes a minute :) 
Start up your rails server with `rails s`
and open localhost:3000 in your browser.

### Prerequisites

Ruby Version: 2.3+
Rails Version: 5+

## Running the tests

To run the test suite, run `rspec` from the root directory in your terminal after following the Getting Started instructions above.

## Built With

* [Mapbox](https://www.mapbox.com/mapbox-gl-js/api/)
* [Twitter OAuth](https://dev.twitter.com/web/sign-in/implementing)
* [ProPublica Congress API](https://projects.propublica.org/api-docs/congress-api)
* [Geocodio API](https://geocod.io/)
* [factorybot](https://github.com/thoughtbot/factory_bot)
* [shoulda matchers](https://github.com/thoughtbot/shoulda-matchers)
* [capybara](https://github.com/teamcapybara/capybara)

## Deployment
Visit the application deployed to Heroku [here](https://rep-check.herokuapp.com/). Currently this app is only built with Colorado data.

## Author
* [Margaret Williford](https://github.com/lilwillifo)
