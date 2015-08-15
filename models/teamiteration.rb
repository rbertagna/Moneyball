require 'nokogiri'
require 'open-uri'
require_relative 'runs-created.rb'

class Team

  def initialize(url)
    doc = Nokogiri::HTML(open(url))
    @team_name = doc.css("#info_box > h1").text
    puts "#{@team_name}:"
    doc.css("#team_batting a").map do |link| #all links of players
      if (href = link.attr("href")) && !href.empty?
        Player_lastseason.new(URI::join(url, href)) #do calculations for players
      end
    end
  end

end



puts 'AL East:'
Yankees = Team.new('http://www.baseball-reference.com/teams/NYY/2015.shtml')
puts
Red_Sox = Team.new('http://www.baseball-reference.com/teams/BOS/2015.shtml')
puts
Blue_Jays = Team.new('http://www.baseball-reference.com/teams/TOR/2015.shtml')
puts
Orioles = Team.new('http://www.baseball-reference.com/teams/BAL/2015.shtml')
puts
Rays = Team.new('http://www.baseball-reference.com/teams/TBR/2015.shtml')
puts

puts 'AL Central:'
Royals = Team.new('http://www.baseball-reference.com/teams/KCR/2015.shtml')
puts
Twins = Team.new('http://www.baseball-reference.com/teams/MIN/2015.shtml')
puts
Tigers = Team.new('http://www.baseball-reference.com/teams/DET/2015.shtml')
puts
White_Sox = Team.new('http://www.baseball-reference.com/teams/CHW/2015.shtml')
puts
Indians = Team.new('http://www.baseball-reference.com/teams/CLE/2015.shtml')
puts

puts 'AL West:'
Astros = Team.new('http://www.baseball-reference.com/teams/HOU/2015.shtml')
puts
Angels = Team.new('http://www.baseball-reference.com/teams/LAA/2015.shtml')
puts
Rangers = Team.new('http://www.baseball-reference.com/teams/TEX/2015.shtml')
puts
Mariners = Team.new('http://www.baseball-reference.com/teams/SEA/2015.shtml')
puts
Athletics = Team.new('http://www.baseball-reference.com/teams/OAK/2015.shtml')
puts

puts 'NL East:'
Mets = Team.new('http://www.baseball-reference.com/teams/NYM/2015.shtml')
puts
National = Team.new('http://www.baseball-reference.com/teams/WSN/2015.shtml')
puts
Braves = Team.new('http://www.baseball-reference.com/teams/ATL/2015.shtml')
puts
Marlins = Team.new('http://www.baseball-reference.com/teams/MIA/2015.shtml')
puts
Phillies = Team.new('http://www.baseball-reference.com/teams/PHI/2015.shtml')
puts

puts 'NL Central:'
Cardinals = Team.new('http://www.baseball-reference.com/teams/STL/2015.shtml')
puts
Pirates = Team.new('http://www.baseball-reference.com/teams/PIT/2015.shtml')
puts
Cubs = Team.new('http://www.baseball-reference.com/teams/CHC/2015.shtml')
puts
Reds = Team.new('http://www.baseball-reference.com/teams/CIN/2015.shtml')
puts
Brewers = Team.new('http://www.baseball-reference.com/teams/MIL/2015.shtml')
puts

puts 'NL West:'
Dodgers = Team.new('http://www.baseball-reference.com/teams/LAD/2015.shtml')
puts
Giants = Team.new('http://www.baseball-reference.com/teams/SFG/2015.shtml')
puts
Diamondbacks = Team.new('http://www.baseball-reference.com/teams/ARI/2015.shtml')
puts
Padres = Team.new('http://www.baseball-reference.com/teams/SDP/2015.shtml')
puts
Rockies = Team.new('http://www.baseball-reference.com/teams/COL/2015.shtml')
puts