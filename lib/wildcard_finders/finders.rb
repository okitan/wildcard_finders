require "capybara/node/finders"

module WildcardFinders
  module Finders
    METHODS = []

    # not to add METHODS
    def find_tag_like(tag, matcher, opts = {})
      tags = all(tag).select do |e|
        hash = matcher.keys.each_with_object({}) {|key, h| h[key] = e[key] }
        WildcardMatchers.wildcard_match?(hash, matcher)
      end

      tags.first # not compatible with capybara 2.x
    end

    def self.method_added(name)
      METHODS.push(name)
    end

    # I'll never add semantic tags
    %w[ image a input form link ].each do |name|
      define_method("find_#{name}_like") do |matcher, opts = {}|
        find_tag_like(name, matcher, opts)
      end
    end

    alias find_anchor_like find_a_like
  end
end
