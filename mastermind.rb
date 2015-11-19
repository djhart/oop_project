class Player
	attr_reader :name, :guess, :ai
	attr_accessor :key, :code, :set
	def initialize(name, ai = 1 )
		@name = name		
		@set = (1..6).to_a.repeated_permutation(4).to_a
		@key = []
		@ai = ai

	end

	def make_code
		@code = []
		(0..3).each {|x| @code[x] = (1 + rand(6))}
	end


	def compare(ans, try)
		result = []
		code_dup = Marshal.load(Marshal.dump(ans))
		try_dup = Marshal.load(Marshal.dump(try))
		code_dup.each_with_index do |x, n|
			if x == try_dup[n]
				result << "b"
				try_dup[n] = 10
				code_dup[n] = 0
			end
		end
		code_dup.each_with_index do |x, n|
			try_dup.each_with_index do |y, m|
				if x == y
					code_dup[n] = 0
					x = 0
					try_dup[m] = 10
					result << "w"
				end
			end
		end	
		return result
	end

	def gen_set(comp, guess)
		self.set.select!{|x| compare(x, guess) == comp}
		return self.set		
	end

	def move(b)	
		@key = []	
		@key = compare(self.code, b)
		@key.count("b").times {print "black "}
		@key.count("w").times {print "white "}
		#puts ""
		print "\nguess: #{b}\n"
		#puts ""
		#print "code: #{self.code}"
		#puts ""
	end

	def over?
		@key.count("b") == 4 ? true : false
	end

	def make_guess(check)			
		@guess = []
		until check.include?(@guess)
			@guess = []
			puts "your guess? four digits 1-6"
			gets.chomp.each_char {|c| @guess << c.to_i}
		end			
	end
end

master = Player.new("master")
puts "Do you want to guess?"
while input = gets.chomp.downcase
	case input
	when "yes"
		guesser = Player.new("guesser", 0)
		break
	when "no"
		guesser = Player.new("guesser")
		break
	else
		puts "Do you want to guess?"
	end
end

master.make_code
a = 0 
check = (1..6).to_a.repeated_permutation(4).to_a
while a < 12
	a += 1
	if guesser.ai == 1
		if a == 1
			b = [1,1,2,2]
		else
			guesser.set = guesser.gen_set(master.key, b)
			b = guesser.set[0]
		end
		master.move(b)
	else
		guesser.make_guess(check)
		b = guesser.guess
		master.move(b)
	end
	if master.over?
		puts "#{guesser.name} wins in #{a} turns!"
		a = 30
	end
end
puts "#{master.name} wins! code was #{master.code}!" if a == 12