# frozen_string_literal: true

require 'nokogiri'
require_relative "tabler_icons_ruby/version"
require_relative "tabler_icons_ruby/helper"

module TablerIconsRuby
  extend self
  class Error < StandardError; end

  def self.render(icon_name, size: nil, color: nil, class: nil, stroke_width: nil, **options)
    root = nokogiri_doc(icon_name).root

    if size
      root.set_attribute('width', size)
      root.set_attribute('height', size)
    end

    if html_class = binding.local_variable_get(:class)
      new_classes = html_class.is_a?(String) ? html_class.split(" ") : Array(html_class)
      classes = (root.classes + new_classes).join(' ')
      root.set_attribute('class', classes)
    end

    root.set_attribute('stroke', color) if color
    root.set_attribute('stroke-width', stroke_width) if stroke_width

    options.each do |attribute_name, attribute_value|
      root.set_attribute(attribute_name, attribute_value)
    end

    root.to_html
  end

  private

  def self.nokogiri_doc(icon_name)
    @icons_cache ||= {}
    @icons_cache[icon_name] ||= Nokogiri::XML(File.read("icons/#{icon_name}.svg"))
    @icons_cache[icon_name].dup
  rescue
    raise Error.new("Could not find icon `#{icon_name}`.")
  end

  if defined?(Rails) && defined?(ActiveSupport)
    ActiveSupport.on_load(:action_view) do
      include TablerIconsRuby::Helper
    end
  end
end
