require './scenario'

if __FILE__ == $0

(20..29).each do |n|
  file_number = n
  scenario = Scenario.new(File.read("stories/anathema_scenario#{file_number}.txt"), file_number)
  scenario.convert_to_denkinovel
  scenario.output('denkinovel')
end


(1..3).each do |n|
  file_number = n
  scenario = Scenario.new(File.read("stories/anathema_scenario#{file_number}.txt"), file_number)
  scenario.convert_to_denkinovel
  scenario.output('denkinovel')
end

end
