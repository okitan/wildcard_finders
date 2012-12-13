require "capybara"
require "wildcard_matchers"

module WildcardFinders
  autoload :Finders,  "wildcard_finders/finders"
  autoload :Matchers, "wildcard_finders/matchers"
end

module Capybara
  module Node
    class Base
      include ::WildcardFinders::Finders, ::WildcardFinders::Matchers
    end
  end

  class Session
    [ ::WildcardFinders::Finders::METHODS, ::WildcardFinders::Matchers::METHODS ].flatten.each do |method|
      define_method(method) do |*args, &block|
        @touched = true
        current_node.__send__(method, *args, &block)
      end
    end
  end
end
