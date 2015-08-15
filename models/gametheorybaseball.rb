

class Baseball

  def Initialize
  end

  def quantify(abs, hits, doubles, triples, hrs, rbi, obp, runs)
    stat = ( 100*hrs/23 + 100*triples/40 + 100*doubles/51 + (hits-(doubles+triples+hrs )))/abs
    return stat
  end

end

Derek_Jeter = Baseball.new

puts 'Derek Jeter is' 
puts Derek_Jeter.quantify(581.0,149.0,19.0,1.0,4.0,50,0.304,47.0)

Miguel_Cabrera = Baseball.new

puts 'Miguel Cabrera is' 
puts Miguel_Cabrera.quantify(611.0, 191.0, 52.0, 1.0, 25.0, 109.0, 0.371, 101.0)

Omar_Infante = Baseball.new

puts "Omar Infante is"
puts Omar_Infante.quantify(528.0, 133.0, 21.0, 3.0, 6.0, 66.0, 0.295, 50.0)

Mike_Napoli = Baseball.new

puts 'Mike Napoli is'
puts Mike_Napoli.quantify(415.0, 103.0, 20.0, 0, 17.0, 55.0, 0.370, 49.0)

Joey_Votto = Baseball.new

puts 'Joey Votto is'
puts Joey_Votto.quantify(220.0, 56.0,  16.0, 0.0, 6.0, 23.0, 0.390, 32.0)

