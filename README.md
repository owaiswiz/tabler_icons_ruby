# TablerIconsRuby
<a href="https://badge.fury.io/rb/tabler_icons_ruby"><img src="https://badge.fury.io/rb/tabler_icons_ruby.svg" alt="Gem Version" height="18"></a> <img alt="Gem Total Downloads" src="https://img.shields.io/gem/dt/tabler_icons_ruby">

* Use any icon from over [4950+ tabler icons.](https://tabler.io/icons)
* Works with/without Rails.
* Easily customize things like size, colors, stroke width, classes & other HTML attributes.
* Renders only icons you actually use as inline SVGs.
* Unnecessary cruft removed - things like the xmlns attributes, width/height attributes (if not providing an explicit size) and the hidden bounding box that tabler icons adds are removed

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add tabler_icons_ruby

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install tabler_icons_ruby

If you're not using Rails, remember to `require 'tabler_icons_ruby'`

## Usage

If you're using this with Rails, you can simply use this helper in your views:

```erb
<%= tabler_icon('player-play') %>

<%= tabler_icon('player-play', size: '18px', color: '#ff00ff') %>

<%= tabler_icon(:player_play, size: 20, color: :red, class: 'any-html-class other-class') %>

<%= tabler_icon('2fa', stroke_width: 2, 'data-controller' => 'something') %>
```

If you're not using Rails, or you'd like to use the `tabler_icon` helper from other places, you can simply include the helper in your class:
```ruby
class SomeClass
  include TablerIconsRuby::Helper

  def call
    "icon: #{tabler_icon('player-play')}"
  end
end
```

If you don't like using the helper, you can render icons directly:
```ruby
TablerIconsRuby.render(
  icon_name,
  size: size_of_icon,
  color: color_of_icon,
  class: html_class_to_add_to_icon,
  stroke_width: stroke_width_of_icon,
  **any_other_attributes_that_will_be_added_to_the_icon_svg_element
)
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/owaiswiz/tabler_icons_ruby.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Future

Might consider also incorporating icon fonts in this library. For that to be true though, I'd have to figure out a way to load things lazily as otherwise it'd load a lot of things. Similar to how modern font awesome kits work. They partition their huge icon set into multiple files. And load thigns on demand.
