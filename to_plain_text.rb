require './scenario'

if __FILE__ == $0
(1..3).each do |n|
  file_number = n
  scenario = Scenario.new(File.read("stories/anathema_scenario#{file_number}.txt"), file_number)
  scenario.convert_to_denkinovel
  scenario.remove_denkinovel_tags
  scenario.output('plain_text')
end

end
