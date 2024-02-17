# frozen_string_literal: true

require 'nokogiri'
require_relative "tabler_icons_ruby/version"
require_relative "tabler_icons_ruby/helper"

module TablerIconsRuby
  extend self
  class Error < StandardError; end

  def self.render(icon_name, size: nil, color: nil, class: nil, stroke_width: nil, **options)
    icon_name = icon_name.to_s.tr('_', '-')
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

    html = root.to_html
    html = html.html_safe if html.respond_to?(:html_safe)
    html
  end

  private

  def self.nokogiri_doc(icon_name)
    @icons_cache ||= {}
    @icons_cache[icon_name] ||= load_nokogiri_doc(icon_name)
    @icons_cache[icon_name].dup
  rescue
    raise Error.new("Could not find icon `#{icon_name}`.")
  end

  def self.load_nokogiri_doc(icon_name)
    file_path = File.join(File.dirname(__FILE__), "../icons/#{icon_name}.svg")
    Nokogiri::XML(File.read(file_path))
  end

  if defined?(Rails) && defined?(ActiveSupport)
    ActiveSupport.on_load(:action_view) do
      include TablerIconsRuby::Helper
    end
  end
end
