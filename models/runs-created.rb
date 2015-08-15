require 'nokogiri'
require 'open-uri'

class Player_per162

  def initialize(name, url)
    @html = open(url) #open url
    @nokogiri = Nokogiri::HTML(@html) # convert to nokogiri
    find_stats
    calculate_a # a, b, c according to https://en.wikipedia.org/wiki/Runs_created
    calculate_b
    calculate_c
    calculate_runs_created
    puts "#{name}: #{runs_created_call}"
  end

  def find_stats
    @stats = {
      :hits => @nokogiri.css('#batting_standard > tfoot > tr:nth-child(2) > td:nth-child(6)').text.to_i,
      :doubles => @nokogiri.css('#batting_standard > tfoot > tr:nth-child(2) > td:nth-child(7)').text.to_i,
      :triples => @nokogiri.css('#batting_standard > tfoot > tr:nth-child(2) > td:nth-child(8)').text.to_i,
      :homeruns => @nokogiri.css('#batting_standard > tfoot > tr:nth-child(2) > td:nth-child(9)').text.to_i,
      :walks => @nokogiri.css('#batting_standard > tfoot > tr:nth-child(2) > td:nth-child(13)').text.to_i,
      :intentionalwalks => @nokogiri.css('#batting_standard > tfoot > tr:nth-child(2) > td:nth-child(25)').text.to_i,
      :hitbypitch => @nokogiri.css('#batting_standard > tfoot > tr:nth-child(2) > td:nth-child(22)').text.to_i,
      :sacrificehits => @nokogiri.css('#batting_standard > tfoot > tr:nth-child(2) > td:nth-child(23)').text.to_i,
      :sacrificefly => @nokogiri.css('#batting_standard > tfoot > tr:nth-child(2) > td:nth-child(24)').text.to_i,
      :stolenbases => @nokogiri.css('#batting_standard > tfoot > tr:nth-child(2) > td:nth-child(11)').text.to_i,
      :caughtstealing => @nokogiri.css('#batting_standard > tfoot > tr:nth-child(2) > td:nth-child(12)').text.to_i,
      :strikeouts => @nokogiri.css('#batting_standard > tfoot > tr:nth-child(2) > td:nth-child(14)').text.to_i,
      :groundintodoubleplays => @nokogiri.css('#batting_standard > tfoot > tr:nth-child(2) > td:nth-child(21)').text.to_i,
      :atbats => @nokogiri.css('#batting_standard > tfoot > tr:nth-child(2) > td:nth-child(4)').text.to_i,
    }
  end

  def calculate_a
    @a = @stats[:hits] + @stats[:walks] - @stats[:caughtstealing] + @stats[:hitbypitch] - @stats[:groundintodoubleplays]
  end

  def calculate_b
    @b = (1.125 * (@stats[:hits] - @stats[:doubles] - @stats[:triples] - @stats[:homeruns])) + (1.69 * @stats[:doubles]) + (3.02 * @stats[:triples]) + (3.73 * @stats[:homeruns]) + (0.29 * (@stats[:walks] - @stats[:intentionalwalks] + @stats[:hitbypitch])) + (0.492 * (@stats[:sacrificehits] + @stats[:sacrificefly] + @stats[:stolenbases])) - (0.04 * @stats[:strikeouts])
  end

  def calculate_c
    @c = @stats[:atbats] + @stats[:walks] + @stats[:hitbypitch] + @stats[:sacrificehits] + @stats[:sacrificefly]
  end

  def calculate_runs_created
    @runs_created = (((2.400 * @c + @a) * (3.000 * @c + @b)) / (9.000 * @c )) - (0.9000 * @c)
  end

  def runs_created_call
    @runs_created
  end

end

class Player_lastseason

  def initialize(url)
    @html = open(url) #open url
    @nokogiri = Nokogiri::HTML(@html) # convert to nokogiri
    @name = @nokogiri.css('#player_name').text
    find_stats
    calculate_a # a, b, c according to https://en.wikipedia.org/wiki/Runs_created
    calculate_b
    calculate_c
    calculate_runs_created
    adjusted_runs_created
    if @adjusted_runs_created > 80 #lineup must average at least 90 runs created
      puts "#{@stats[:position]} #{@name}: #{@adjusted_runs_created}"
    end
  end

  def find_stats
    @stats = {
      :hits => @nokogiri.css('#batting_standard > tbody > tr.full:last-of-type > td:nth-child(9)').text.to_i,
      :doubles => @nokogiri.css('#batting_standard > tbody > tr.full:last-of-type > td:nth-child(10)').text.to_i,
      :triples => @nokogiri.css('#batting_standard > tbody > tr.full:last-of-type > td:nth-child(11)').text.to_i,
      :homeruns => @nokogiri.css('#batting_standard > tbody > tr.full:last-of-type > td:nth-child(12)').text.to_i,
      :walks => @nokogiri.css('#batting_standard > tbody > tr.full:last-of-type > td:nth-child(16)').text.to_i,
      :intentionalwalks => @nokogiri.css('#batting_standard > tbody > tr.full:last-of-type > td:nth-child(28)').text.to_i,
      :hitbypitch => @nokogiri.css('#batting_standard > tbody > tr.full:last-of-type > td:nth-child(25)').text.to_i,
      :sacrificehits => @nokogiri.css('#batting_standard > tbody > tr.full:last-of-type > td:nth-child(26)').text.to_i,
      :sacrificefly => @nokogiri.css('#batting_standard > tbody > tr.full:last-of-type > td:nth-child(27)').text.to_i,
      :stolenbases => @nokogiri.css('#batting_standard > tbody > tr.full:last-of-type > td:nth-child(14)').text.to_i,
      :caughtstealing => @nokogiri.css('#batting_standard > tbody > tr.full:last-of-type > td:nth-child(15)').text.to_i,
      :strikeouts => @nokogiri.css('#batting_standard > tbody > tr.full:last-of-type > td:nth-child(17)').text.to_i,
      :groundintodoubleplays => @nokogiri.css('#batting_standard > tbody > tr.full:last-of-type > td:nth-child(24)').text.to_i,
      :atbats => @nokogiri.css('#batting_standard > tbody > tr.full:last-of-type > td:nth-child(7)').text.to_i,
      :plate_appearences => @nokogiri.css('#batting_standard > tbody > tr.full:last-of-type > td:nth-child(6)').text.to_i,
      :position => @nokogiri.css('#batting_standard > tbody > tr.full:last-of-type > td:nth-child(29)').text,
    }
  end

  def calculate_a
    @a = @stats[:hits] + @stats[:walks] - @stats[:caughtstealing] + @stats[:hitbypitch] - @stats[:groundintodoubleplays]
  end

  def calculate_b
    @b = (1.125 * (@stats[:hits] - @stats[:doubles] - @stats[:triples] - @stats[:homeruns])) + (1.69 * @stats[:doubles]) + (3.02 * @stats[:triples]) + (3.73 * @stats[:homeruns]) + (0.29 * (@stats[:walks] - @stats[:intentionalwalks] + @stats[:hitbypitch])) + (0.492 * (@stats[:sacrificehits] + @stats[:sacrificefly] + @stats[:stolenbases])) - (0.04 * @stats[:strikeouts])
  end

  def calculate_c
    @c = @stats[:atbats] + @stats[:walks] + @stats[:hitbypitch] + @stats[:sacrificehits] + @stats[:sacrificefly]
  end

  def calculate_runs_created
    @runs_created = (((2.400 * @c + @a) * (3.000 * @c + @b)) / (9.000 * @c )) - (0.9000 * @c)
  end

  def adjusted_runs_created
    @adjusted_runs_created = @runs_created / @stats[:plate_appearences] * 700
  end

  def runs_created_call
    @runs_created
  end

end

# Mike_Trout = Player_per162.new('Mike Trout', 'http://www.baseball-reference.com/players/t/troutmi01.shtml')
# Derek_Jeter = Player_per162.new('Derek Jeter', 'http://www.baseball-reference.com/players/j/jeterde01.shtml')

# puts
# puts 'Yankees:'
# Jacoby_Ellsbury = Player_lastseason.new('http://www.baseball-reference.com/players/e/ellsbja01.shtml')
# Brett_Gardner = Player_lastseason.new('http://www.baseball-reference.com/players/g/gardnbr01.shtml')
# Alex_Rodriguez = Player_lastseason.new('http://www.baseball-reference.com/players/r/rodrial01.shtml')
# Mark_Texiera = Player_lastseason.new('http://www.baseball-reference.com/players/t/teixema01.shtml')
# Brian_McCann = Player_lastseason.new('http://www.baseball-reference.com/players/m/mccanbr01.shtml')
# Carlos_Beltran = Player_lastseason.new('http://www.baseball-reference.com/players/b/beltrca01.shtml')
# Chase_Headley = Player_lastseason.new('http://www.baseball-reference.com/players/h/headlch01.shtml')
# Stephen_Drew = Player_lastseason.new('http://www.baseball-reference.com/players/d/drewst01.shtml')
# Didi_Gregorious = Player_lastseason.new('http://www.baseball-reference.com/players/g/gregodi01.shtml')
# puts
# Chris_Young = Player_lastseason.new('http://www.baseball-reference.com/players/y/youngch04.shtml')
# Greg_Bird = Player_lastseason.new('http://www.baseball-reference.com/players/b/birdgr01.shtml')
# Brendan_Ryan = Player_lastseason.new('http://www.baseball-reference.com/players/r/ryanbr01.shtml')
# John_Ryan_Murphy = Player_lastseason.new('http://www.baseball-reference.com/players/m/murphjr01.shtml')
# puts Jacoby_Ellsbury.runs_created_call + Brett_Gardner.runs_created_call + Alex_Rodriguez.runs_created_call + Mark_Texiera.runs_created_call + Brian_McCann.runs_created_call + Carlos_Beltran.runs_created_call + Chase_Headley.runs_created_call + Stephen_Drew.runs_created_call + Didi_Gregorious.runs_created_call + Chris_Young.runs_created_call + Brendan_Ryan.runs_created_call + John_Ryan_Murphy.runs_created_call


