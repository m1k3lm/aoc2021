depths = File.open("input.txt", "r").readlines.map(&:to_i)
puts "Part1 result is:",depths.each_with_index.count{ |depth,i| i>0 && depth > depths[(i -1)] }
puts "Part2 result is:",depths.each_with_index.count{ |depth,i| i>3 && depth > depths[(i -3)] }