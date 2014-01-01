require 'rmagick'
require 'yaml'

# Fa2png class
class Fa2png
  IMPORT_DIR_TEMPLATE = './import/%s'
  EXPORT_DIR_TEMPLATE = './export/%s'
  IMPORT_FONT_FILENAME = 'fontawesome-webfont.ttf'
  IMPORT_YAML_FILENAME = 'icons.yml'

  def initialize(version: , size: 128, threshold: 0.01)
    @width = size
    @height = size
    @font_size = (size * 0.9).ceil
    @version = version
    @import_dir = IMPORT_DIR_TEMPLATE % @version
    @export_dir = EXPORT_DIR_TEMPLATE % @version
    @font_path = File.expand_path("#{@import_dir}/#{IMPORT_FONT_FILENAME}")
    # TODO: remove magic numbers
    @char_position = { x: @width * 0.53, y: (@font_size + @height) * 0.43 }
    @threshold = threshold
  end

  def compare_all(old_version, new_version = @version)
    icons_data.select do |icon_data|
      diff = difference(icon_data[:id], old_version, new_version)
      icon_data.merge!(diff: diff)
      difference?(diff)
    end
  end

  def difference(icon_id, old_version, new_version = @version)
    new_image_dir = "#{EXPORT_DIR_TEMPLATE % new_version}/icons"
    old_image_dir = "#{EXPORT_DIR_TEMPLATE % old_version}/icons"
    new_image = Magick::ImageList.new("#{new_image_dir}/fa-#{icon_id}.png")
    old_image = Magick::ImageList.new("#{old_image_dir}/fa-#{icon_id}.png")
    new_image.difference(old_image)
  end

  def difference?(diff, threshold = @threshold)
    diff[1] > threshold
  end

  def draw_char(draw, image, char, char_position = @char_position)
    draw.font = @font_path
    draw.fill = '#000000'
    draw.gravity = Magick::CenterGravity
    draw.stroke = 'transparent'
    draw.pointsize = @font_size
    draw.text_antialias = true
    draw.kerning = 0
    draw.text_align(Magick::CenterAlign)
    draw.text(char_position[:x], char_position[:y], char)
    draw.draw(image)
  end

  def generate(icon_data)
    id = icon_data[:id]
    unicode = icon_data[:unicode]
    char = [Integer("0x#{unicode}")].pack('U*')

    draw = Magick::Draw.new
    image = Magick::Image.new(@width, @height)
    draw_char(draw, image, char)

    puts export_path = "#{@export_dir}/icons/fa-#{id}.png"
    image.write(export_path)
  end

  def generate_all
    icons_data.each { |icon_data| generate(icon_data) }
  end

  def icons_data
    result = []
    icons_data_yml.each do |icon|
      result << { id: icon['id'], unicode: icon['unicode'] }
      next unless icon['aliases']
      icon['aliases'].each do |alias_name|
        result << { id: alias_name, unicode: icon['unicode'] }
      end
    end
    result
  end

  def icons_data_yml
    yml_path = File.expand_path("#{@import_dir}/#{IMPORT_YAML_FILENAME}")
    YAML.load_file(yml_path)['icons']
  end
end
