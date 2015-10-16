Class Space
	attr_accessor :state
	attr_reader :num
	@@board = {}
	def initialize(num)
		@num = num
		@state = num
		@@board[num] = @state
	end

	def num
		@num
	end

	def state
		@state
	end

	def show
		print self.state
		if self.num % 3 == 0 || self.num % 6 == 0 || self.num % 9 == 0 
			print "\n"
		end
	end

	def change(player)
		self.state = player
	end


end

Class Player
	attr_reader :name

	def initialize(name)
		@name = name
	end

	def turn
		puts "choose a space"
		a = gets.chomp
