

class Game

	def initialize
		@wordlist = [] 
		@word = ""	
		@guess = ""
		@tries = 0
		@hiddenword = ""
		File.foreach("5desk.txt") do |line|
			if line.length>4 && line.length<13
				@wordlist.push(line)
			end
		end

		
	end

	def savegame
		if File.exist?("savegame.txt")
			File.delete("savegame.txt")
		end

		save = File.new("savegame.txt","w+")

		
		save.puts @word
		save.puts @tries
		save.puts @hiddenword
		save.close

		puts "game saved!"
	end

	def loadgame
		File.open("savegame.txt").each_with_index do |line,i|
			if i == 0
				@word = line.chomp
			elsif i == 1
				@tries = line.chomp.to_i
			elsif i == 2
				@hiddenword = line.chomp
			end
		end
		puts "Previous game loaded successsfully!"
		puts "Remaining tries: #{@tries}"
		puts " "
		puts " "
	end

	def contains?(word,char)
		word.each_char do |c|
			if c == char
				return true
			end
		end
		return false
	end

	def positions (word, char)
		poses = []
		word.each_char.to_a.each_with_index do |c,i|
			if c == char
				poses.push(i)
			end
		end
		return poses
	end


	def play
		while(@tries>0)
			puts " "
			puts @hiddenword
			@guess = gets.chomp[0]
			if @guess == "+"
				savegame()
				@guess = gets.chomp[0]
			end

			if contains?(@word,@guess)
				poses = positions(@word,@guess)
				poses.each do |iter|
					@hiddenword[iter]=@guess
				end
			end
		@tries -= 1
		if contains?(@hiddenword,"_") == false
			puts "you won!"
			puts " "
			puts "the hidden word was: #{@hiddenword}"
			break
		end
		end
		puts " "
		puts "end"
				



	end



	def startgame
		puts "Do you want to"
		puts "(s)tart new game"
		puts "(l)oad previous game"
		puts "(+)to save the game, instead of a guess "

		input = gets.chomp
		if input == "s"
			len = @wordlist.length
			@word = @wordlist[rand(len)]		
			@tries = 7
			len = @word.length-2
			len.times do 
				@hiddenword += "_"
			end
			play()

		elsif input == "l"
			loadgame()
			play()			
		end
	end

end




newgame = Game.new

newgame.startgame