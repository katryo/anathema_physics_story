class Scenario
  attr_accessor :text
  def initialize(text, file_number)
    @text = text
    @file_number = file_number
  end
  def output(type)
    output_file = open("stories/anathema_#{type}#{@file_number}.txt", "w")
    output_file.write(self.text)
    output_file.close
  end

  def convert_to_denkinovel
    @text.gsub!(/^;.*(\r\n|\n)/, "")
    @text.gsub!(/^\[.*(\r\n|\n)/, "")
    @text.gsub!(/^□.*\n/, "")
    @text.gsub!(/^【.*】/, "")
    @text.gsub!(/(\[.*?\])/, "")
    @text.gsub!(/;;＠(\n|\r\n)/, "\n[page]")
    @text.gsub!(/(\r\n|\n){4}/, "\n[page]")
    @text.gsub!(/\r\n\r\n/, "")
    @text.gsub!(/\n\n/, "")
    @text.gsub!(/\{(.*?)\}/, '[\1]')
    @text.gsub!(/\]\r\n/, ']')
    @text.gsub!(/\]\n/, ']')
    @text.gsub!(/[page]\r\n/, '[page]')
  end

  def remove_denkinovel_tags
    @text.gsub!(/\[.*?\]/, '')
  end
end
