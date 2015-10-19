
class Player
	attr_reader :name 
	attr_accessor :owns, :board
	@@board = {}
	@@owned = []
	(1..9).to_a.each { |val| @@board[val.to_s.to_sym] = val}

	def initialize(name)
		@name = name
		@owns = []
	end

	def Player.board
		@@board
	end

	def turn 
		pick = 0	
		while pick ==0	
			puts "\n#{self.name} : where do you play"
			pick = gets.chomp
			if (1..9).include?(pick.to_i) && !(@@owned.include?(pick.to_i))
				self.owns << pick.to_i
				@@owned << pick.to_i				
				@@board[pick.to_sym] = self.name
			else
				pick = 0
			end
		end
	end

	def win?
		w = 0
		win_cond = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
		(0...8).each { |a| w = 1 if (win_cond[a] & self.owns).length == 3 }
		return w == 1 ? true : false

	end

end

def display(game)
	game.each_with_index do |(x,y),i| 
		print y
		print "\n" if (i+1) % 3 == 0 
	end
end

a = 0
puts "X or O?" unless a == "X" || a == "O"
a = gets.chomp.upcase
b = (a == "X" ?  "O" :  "X")
player1 = Player.new(a)
player2 = Player.new(b)
players = [player1, player2]
puts "Player 1 : #{player1.name}"
puts "Player 2 : #{player2.name}"

move = 0
while move < 9
	display(Player.board)
	a = move % 2 
	players[a].turn		
	if players[a].win? 
		puts "#{players[a].name} wins!"
		move = 100
	else
		move += 1
	end
end

display(Player.board)
	