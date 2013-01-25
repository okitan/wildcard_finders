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
    %w[ img a input form link ].each do |name|
      define_method("find_#{name}_like") do |matcher, opts = {}|
        find_tag_like(name, matcher, opts)
      end
    end

    # synonym
    { "a"   => %w[ anchor ],
      "img" => %w[ image  ],
    }.each do |tag, synonyms|
      synonyms.each do |synonym|
        alias "find_#{synonym}_like".to_sym "find_#{tag}_like".to_sym
      end
    end
  end
end
