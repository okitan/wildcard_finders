require "capybara/node/finders"

module WildcardFinders
  module Finders
    METHODS = []

    # not to add METHODS
    def find_tag_like(tag, matcher = nil, opts = {}, &block)
      tags = all(tag).select do |e|
        if matcher.is_a?(Hash)
          hash = matcher.keys.each_with_object({}) {|key, h| h[key] = e[key] }
          WildcardMatchers.wildcard_match?(hash, matcher)
        elsif block_given? or matcher.is_a?(Proc)
          WildcardMatchers.wildcard_match?(e, block || matcher)
        elsif matcher # I don't know this behavior
          WildcardMatchers.wildcard_match?(e, matcher)
        else
          raise "no matcher or block is not given"
        end
      end

      tags.first # not compatible with capybara 2.x
    end

    def self.method_added(name)
      METHODS.push(name)
    end

    # I'll never add semantic tags
    %w[ img a input form link ].each do |name|
      define_method("find_#{name}_like") do |matcher = nil, opts = {}, &block|
        find_tag_like(name, matcher, opts, &block)
      end
    end

    # synonym
    { "a"   => %w[ anchor ],
      "img" => %w[ image  ],
    }.each do |tag, synonyms|
      synonyms.each do |synonym|
        module_eval %{
          alias find_#{synonym}_like find_#{tag}_like
        }
      end
    end
  end
end
