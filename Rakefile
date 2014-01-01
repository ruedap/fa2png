require './lib/fa2png'

NEW_VERSION = '4.0.3'
OLD_VERSION = '4.0.2'

desc 'Compare icon png files.'
task :compare do
  fa2png = Fa2png.new(version: NEW_VERSION)
  result = fa2png.compare_all(OLD_VERSION)
  result.sort! { |a,b| a[:diff][1] <=> b[:diff][1] }
  puts result
  puts "#{result.size} files difference in #{fa2png.icons_data.size} files."
end

desc 'Generate icon png files from Font Awesome ttf file.'
task :generate do
  Fa2png.new(version: NEW_VERSION).generate_all
end

desc 'Remove icon png files.'
task :remove do
  sh %Q|rm ./export/#{NEW_VERSION}/icons/fa-*.png|
end

task default: :generate
