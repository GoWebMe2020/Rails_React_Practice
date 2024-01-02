# Rails Template Backend

## Description

This is a template to demonstrate how to setup a Rails backend with a ReactJS frontend. The intention is to allow users to fork this repo or use from a template, along with the ReactJS template, configure it and use it to their liking.

## Technologies & References

* Rails 7 (https://guides.rubyonrails.org/7_0_release_notes.html)
* Postgres (https://www.postgresql.org | )
* Dotenv (https://github.com/bkeepers/dotenv)
* Devise (https://github.com/heartcombo/devise)
* JWT (https://github.com/jwt/ruby-jwt)
* RSpec (https://github.com/rspec/rspec-rails)
* Factory Bot Rails (https://github.com/thoughtbot/factory_bot_rails)
* Faker (https://github.com/faker-ruby/faker)

## How To Use This Repo

#### Using the Repository as a Template

To create a new repository from this template:

* Navigate to the template repository on GitHub.
* Click the "Use this template" button.
* Choose the owner, name, description, and visibility for your new repository.
* Click "Create repository from template."

#### Forking the Repository

To fork the repository (which is slightly different from using it as a template):

* Navigate to the original repository on GitHub.
* Click the "Fork" button in the top right corner.
* Choose the account where you want to fork the repository.

#### Rename and Customize the Forked Repository

After forking or creating a new repository from the template, you can rename and customize it:

Clone the forked or new repository to your local machine.
Make your changes, rename files, customize code, etc.
Commit and push these changes back to GitHub.
```bash
  $ git commit -am "Customizing template"
  $ git push origin master
```

#### Important

**Be sure to fork the ReactJS frontend template related to the repo <URL>**

#### Additional Notes

Remember to update environment-specific settings (like database configuration) for each new project you create from the template.

## Setup From Scratch

1. Ensure that you have the necessary technologies for this application. Refer to the list Technologies & References and visit the relevant websites to learn how to install them.

2. To Create New Rails Project:

  ```bash
    $ rails new <app_name> --api -d postgresql
  ```
This creates a new Rails API app with PostgreSQL as the database.

3. Configure Database:

  * Adding the role to postgres for the app
  ```bash
    $ psql
    > CREATE ROLE <app_name> WITH SUPERUSER LOGIN PASSWORD '<password>';
    # If this action was successful you will get the below message.
    CREATE ROLE
    > exit
  ```
  * Edit `config/database.yml` to set up your PostgreSQL credentials using Dotenv.
    - Create a `.env` file in your root directory and insert you database username and password. Ensure that this file is listed in your gitignore file and never commit and submit this file to Github.
  ```ruby
    default: &default
      adapter: postgresql
      encoding: unicode
      pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
      username: <%= ENV["TEMPLATE_RAILS_BACKEND_DATABASE_USERNAME"] %>
      password: <%= ENV["TEMPLATE_RAILS_BACKEND_DATABASE_PASSWORD"] %>

    development:
      <<: *default
      database: appname_development
  ```
  * Create your database.
  ```bash
    $ rails db:setup
    # or
    $ rails db:create
  ```

4. Create your database.
  ```bash
    $ rails s
  ```

## Testing

To run the tests, simply type
```bash
  $ rspec
```

# Other
