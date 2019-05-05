# README

### Overview:
  This repo is from a project which was assigned at the beginning of Mod 3 at Turing School of Software and Design. The purpose of the project was to build a number of API endpoints, based on a large data set involving customers, merchants, items, invoices, and transactions. These endpoint types were broken down into three categories: Search/Find, Relationships, and Business Intelligence (which required advanced Active Record and SQL queries).

### Versions:

* Ruby version: 2.4.1
* Rails version: 5.2.3
* Database: Postgresql

### Setup and Configuration:

  Clone down this repo to your local machine:\
  $ git clone `git@github.com:CSheesley/rails_engine.git`

  From your command line run:\
  $ `bundle`\
  $ `rake db:{drop,create,migrate}`

  To populate tables, run:\
  $ `rake import:{customer,merchant,invoice,item,invoice_item,transaction}`

  Finally, in a directory adjacent to the code base that you just cloned - clone the following directory which can be used for testing with a `spec harness`.\
  $ git clone `https://github.com/turingschool/rales_engine_spec_harness`

### Testing:

#### Local Testing

  In the `rails_engine` repo, `rspec` is being used to test API responses and JSON output, along with model tests. Simply run `rspec` in your terminal to run all local tests for this repo.

#### Spec Harness

  The `spec harness` (details below) was the primary method of testing for this repo. To run the `rails_engine` code base against the `rales_engine_spec_harness`, `cd` into each directory.

  From the `rails_engine` directory, run `rails s` in the command line to start the server, which is necessary for the `spec harness` to evaluate endpoints.

  From the `rails_engine_spec_harness`, type `rake` into your command line to run all tests. Currently all tests should be passing - with one test skipped.

  `ruby test/business_logic/merchant_business_logic -n test_loads_the_customers_with_pending_invoices_associated_with_one_merchant`

  This test is focused on some advanced business logic - feel free to give it a shot!

### Schema Diagram
![Rails Engine Schema](/schema_diagram.png?raw=true "Rails Engine Schema")
