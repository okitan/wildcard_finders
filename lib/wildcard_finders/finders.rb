require "capybara/node/finders"

module WildcardFinders
  module Finders
    METHODS = []

    def self.method_added(name)
      METHODS.push(name)
    end

    def find_image_like(matcher)
      all("img").select do |e|
        hash = matcher.keys.each_with_object({}) {|key, h| h[key] = e[key] }
        WildcardMatchers.wildcard_match?(hash, matcher)
      end.first # not compatible with capybara 2.x
    end
  end
end
