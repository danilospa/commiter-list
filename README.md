# Commiters list

Creates a file describing all the commiters from [BraspagRest](https://github.com/Dinda-com-br/braspag-rest) repository ordered by commits count.

## Instructions

### Dependencies

- Ruby 2.4.1

### How to setup

Just run `bundle install`.

### How to run tests

Just run `bundle exec rspec`.

### How to run application

After requiring the main class, just call the method `create_report`
```
require './app'

App.new.create_report
```

Or you can run the example file directly
```
ruby example.rb
```
