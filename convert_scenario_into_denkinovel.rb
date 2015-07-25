#coding:utf-8
class Scenario
  attr_accessor :text
  def initialize(text, file_number)
    @text = text
    @file_number = file_number
  end
  def convert_and_output
    self.convert
    output_file = open("stories/anathema_denkinovel#{@file_number}.txt", "w")
    output_file.write(self.text)
    output_file.close
  end

  def convert
    @text.gsub!(/^;.*(\r\n|\n)/, "")
    @text.gsub!(/^\[.*(\r\n|\n)/, "")
    @text.gsub!(/^□.*\n/, "")
    @text.gsub!(/^【.*】/, "")
    @text.gsub!(/(\[.*?\])/, "")
    @text.gsub!(/;;＠(\n|\r\n)/, "\n[page]")
    @text.gsub!(/(\r\n|\n){3,4}/, "\n[page]")
    @text.gsub!(/\r\n\r\n/, "")
    @text.gsub!(/\n\n/, "")
    @text.gsub!(/\{(.*?)\}/, '[\1]')
    @text.gsub!(/\]\r\n/, ']')
    @text.gsub!(/\]\n/, ']')
    @text.gsub!(/[page]\r\n/, '[page]')
  end
end


(20..29).each do |n|
  file_number = n
  scenario = Scenario.new(File.read("stories/anathema_scenario#{file_number}.txt"), file_number)
  scenario.convert_and_output
end


(1..2).each do |n|
  file_number = n
  scenario = Scenario.new(File.read("stories/anathema_scenario#{file_number}.txt"), file_number)
  scenario.convert_and_output
end
