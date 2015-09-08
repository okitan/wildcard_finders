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

        rspec_matcher_method                  = method.to_s.sub("find", "have")
        rspec_matcher_method_without_block    = method.to_s.sub("find", "have")    + "_without_block"
        rspec_no_matcher_method               = method.to_s.sub("find", "have_no")
        rspec_no_matcher_method_without_block = method.to_s.sub("find", "have_no") + "_without_block"

        define_method(matcher_method) do |*args, &block|
          begin
            __send__(method, *args, &block)
            true
          rescue ::Capybara::ElementNotFound
            false
          end
        end

        define_method(no_matcher_method) do |*args, &block|
          begin
            __send__(method, *args, &block)
            false
          rescue ::Capybara::ElementNotFound
            true
          end
        end

        RSpec::Matchers.define(rspec_matcher_method_without_block) do |expected|
          match do |page|
            page.__send__(matcher_method, expected)
          end
        end

        RSpec::Matchers.define(rspec_no_matcher_method_without_block) do |expected|
          match do |page|
            page.__send__(no_matcher_method, expected)
          end
        end

        # Note: block_given? does not work in define_method
        RSpec::Matchers.__send__(:define_method, rspec_matcher_method) do |expected = nil, &block|
          __send__(rspec_matcher_method_without_block, (block ? block : expected))
        end

        RSpec::Matchers.__send__(:define_method, rspec_no_matcher_method) do |expected = nil, &block|
          __send__(rspec_no_matcher_method_without_block, (block ? block : expected))
        end
      end
    end
  end
end
