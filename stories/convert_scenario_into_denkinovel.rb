#coding:utf-8
class Scenario
  attr_accessor :text
  def initialize(text, file_number)
    @text = text
    @file_number = file_number
  end
  def convert_and_output
    self.convert
    output_file = open("anathema_denkinovel#{@file_number}.txt", "w")
    output_file.write(self.text)
    output_file.close
  end

  def convert
    @text.gsub!(/^;.*\n/, "")
    @text.gsub!(/^\[.*\n/, "")
    @text.gsub!(/^□.*\n/, "")
    @text.gsub!(/^【.*】/, "")
    @text.gsub!(/(\[.*?\])/, "")
    @text.gsub!(/;;＠\r\n/, "\n[page]")
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
  scenario = Scenario.new(File.read("anathema_scenario#{file_number}.txt"), file_number)
  scenario.convert_and_output
end

file_number = 1
scenario = Scenario.new(File.read("anathema_scenario#{file_number}.txt"), file_number)
scenario.convert_and_output
