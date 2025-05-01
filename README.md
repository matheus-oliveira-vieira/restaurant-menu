
# Restaurant Menu API

  
A scalable RESTful API for restaurant menu management built with Ruby on Rails, following iterative development principles.


## Features


### Core Functionality

-  **Restaurant CRUD** with nested menus

-  **Multi-level relationships** (Restaurant → Menu → MenuItem)

-  **JSON data importer** with transaction safety

-  **RSpec test coverage** (models, requests, services)

  

## Technical Stack

-  **Framework:** Rails 8.0.1

-  **Database:** PostgreSQL

-  **Testing:** RSpec + FactoryBot

  

## Installation

```bash
git  clone  git@github.com:matheus-oliveira-vieira/restaurant-menu.git

cd  restaurant-menu

bundle  install

rails  db:setup
```
## Endpoints

-  **GET /api/v1/import** Import data from JSON

- **GET /api/v1/restaurants/:restaurant_id/menus** Loads all restaurant menus with their items

-  **GET /api/v1/restaurants/:restaurant_id/menus/:id** Loads a specific restaurant menus with their items

-  **GET /api/v1/restaurants** Loads all restaurants

-  **GET /api/v1/restaurants/:id** Loads a specific restaurant

## Test
Run the command below to execute all tests

```bash
rspec
```

## Serialize JSON
Run the command below to serialize JSON file

```bash
rails import:json
```

## How to run the Application
In a terminal, run the following command to run the application.

```bash
bin/dev
```

In another terminal, run the command to upload the CSS changes

```bash
yarn build:css
```

## License

MIT. Use and adapt freely!