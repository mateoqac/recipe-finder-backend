# Recipe App

Welcome to the Recipe App! This Ruby on Rails application provides an API for managing and retrieving recipes. It includes functionality for listing recipes, searching for recipes by ingredient, and paginating through the results.

## Getting Started

### Prerequisites

Make sure you have the following installed:

- Ruby (version 3.2.2)
- Ruby on Rails (version 7.1)
- PostgreSQL

### Installation

1. Clone the repository:

   ```bash
   git clone git@github.com:mateoqac/recipe-finder-backend.git

2. Move to the project directory:
   ```bash
   cd recipe-app

3. Install dependencies:
   ```bash
   bundle install

4. Set up the database:
   ```bash
   rails db:create
   rails db:migrate

5. Load the database with some sample data:
   ```ruby
   rake db:load_recipes

6. Running the server
   ```bash
   rails server

## Accessing the Application

The application will be accessible at [http://localhost:3000](http://localhost:3000).

## API Endpoints

### List Recipes

- **Endpoint:** `/` or `/api/v1/recipes/`
- **Method:** `GET`
- **Description:** Retrieve a list of recipes.
- **Pagination:** Default page size is 12.

### Find Recipes by Ingredient

- **Endpoint:** `/api/v1/recipes/find`
- **Method:** `POST`
- **Description:** Search for recipes based on a single ingredient or multiple ingredients.
- **Parameters:**
  - `ingredient` (string): Search for recipes with a single/multiple ingredients (splitted by comma)

## Testing

The project includes RSpec tests for the API endpoints. Run the tests with:

```bash
bundle exec rspec
