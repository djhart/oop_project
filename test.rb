win_cond = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
arr = [4,5,6]
#(0...8).each { |a| print "#{win_cond[a]}" +"\n" }
#(0...8).each { |a| puts ((win_cond[a] & arr) == win_cond[a]) ? "yes" : "no"}
(0...8).each { |a| print (win_cond[a] & arr).length }