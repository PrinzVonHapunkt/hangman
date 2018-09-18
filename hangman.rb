#methods needes: play() startgame()  loadgame() savegame()  randomword()  guess()

class Game

	def initialize
		@wordlist = [] 
		@word = ""	
		File.foreach("5desk.txt") do |line|
			if line.length>4 && line.length<13
				@wordlist.push(line)
			end
		end

		
	end

	def play
	end


	def startgame
		puts "Do you want to"
		puts "(s)tart new game"
		puts "(l)oad previous game"

		input = gets.chomp
		if input == "s"
			len = @wordlist.length
			@word = @wordlist[rand(len)]		
			puts @word
		end
	end

end




newgame = Game.new

newgame.startgame