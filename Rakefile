require './lib/fa2png'

NEW_VERSION = '5.5.0'
OLD_VERSION = '4.6.3'

desc 'Compare PNG files with previous version'
task :compare do
  puts "# NEW_VERSION: #{NEW_VERSION} <=> OLD_VERSION: #{OLD_VERSION}"
  fa2png = Fa2png.new(version: NEW_VERSION)
  result = fa2png.compare_all(OLD_VERSION)
  result.sort! { |a, b| a[:diff][1] <=> b[:diff][1] }
  puts result
  puts "#{result.size} files difference in #{fa2png.icons_data.size} files."
end

desc 'Generate PNG files from Font Awesome TTF file'
task :generate do
  Fa2png.new(version: NEW_VERSION).generate_all
end

desc 'Remove PNG files'
task :remove do
  sh %Q|rm ./export/#{NEW_VERSION}/icons/*.png|
end

task default: :generate
