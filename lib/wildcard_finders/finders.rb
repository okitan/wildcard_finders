require "capybara/node/finders"
require "xpath"

module WildcardFinders
  module Finders
    METHODS = []

    # not to add METHODS
    def find_tag_like(tag, matcher = nil, opts = {}, &block)
      if matcher.is_a?(Hash) && matcher.values.all? {|v| v.is_a?(String) }
        find_exactly(tag, matcher)
      else
        all(tag).select do |e|
          if matcher.is_a?(Hash)
            hash = matcher.keys.each_with_object({}) {|key, h| h[key] = e[key] }
            WildcardMatchers.wildcard_match?(hash, matcher)
          else
            WildcardMatchers.wildcard_match?(e, block || matcher)
          end
        end.first # not compatible with capybara 2.x
      end
    end

    def find_exactly(tag, matcher)
      xpath = XPath.generate do |x|
        attr_matcher = matcher.map do |key, value|
          case key
          when :text
            x.text.equals(value)
          when :class
            x.attr(:class).contains(value)
          else
            x.attr(key).equals(value)
          end
        end

        x.descendant(tag.to_sym)[attr_matcher.inject(&:&)]
      end

      find(:xpath, xpath)
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
