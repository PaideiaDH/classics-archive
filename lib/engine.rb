module YourModule
  class Engine < Rails::Engine
    # => ExceptionHandler
    # => Works in and out of an initializer
    config.exception_handler = {
      dev: true,
      db:  true
    }
  end
end
