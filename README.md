# Commiters list

Creates a file describing all the commiters from [BraspagRest](https://github.com/Dinda-com-br/braspag-rest) repository ordered by commits count.

## Project Design

The `interactors/organizers` design used on this application to handle use cases is based on the [interactor gem](https://github.com/collectiveidea/interactor). This pattern encourages the use of single responsibility classes, which creates improves testing and create more readable and reusable code.

I also used the `build` pattern to handle the creation of the classes. The method `build` knows how to initialize the class it resides. This way, the user can use it to instantiate a object or he can use the constructor directly to inject the desired dependencies. It decouples the code which improves maintainability and testing. 

## Code coverage

All core classes are covered by unit tests.
The main class `App` has an integration test to guarantee the correct behavior between the classes. On this case, external dependencies were mocked: datetime ([Timecop](https://github.com/travisjeffery/timecop)), file system ([FakeFS](https://github.com/fakefs/fakefs)) and HTTP requests ([WebMock](https://github.com/bblimke/webmock)).

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

It will create a file on the current directory containing the committers from the repository.
