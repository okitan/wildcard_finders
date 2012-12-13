require "capybara/node/matchers"

module WildcardFinders
  module Matchers
    METHODS = []

    def self.method_added(name)
      METHODS.push(name)
    end

    ::WildcardFinders::Finders::METHODS.each do |method|
      if method =~ /\Afind_/
        matcher_method    = method.to_s.sub("find", "has") + "?"
        no_matcher_method = method.to_s.sub("find", "has_no") + "?"

        define_method(matcher_method) do |*args, &block|
          wait_method = respond_to?(:synchronize) ? :synchronize : :wait_until

          __send__(wait_method) do
            result = __send__(method, *args, &block)
            result or raise Capybara::ExpectationNotMet, "no results for #{matcher_method}:#{args}"
          end

          true
        end

        define_method(no_matcher_method) do |*args, &block|
          wait_method = respond_to?(:synchronize) ? :synchronize : :wait_until

          __send__(wait_method) do
            result = __send__(method, *args, &block)
            result and raise Capybara::ExpectationNotMet, "some results for #{matcher_method}:#{args}"
          end

          true
        end
      end
    end
  end
end
