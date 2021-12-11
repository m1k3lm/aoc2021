require 'set'
class Puzzle
  attr_accessor :signals, :outputs
  def initialize(filename)
      @signals = []
      @outputs = []
      inputs = File.open(filename, "r").readlines.map { |line| line.chomp }
      inputs.each do |line|
        parts = line.split(" | ")
        @signals << parts[0].split(" ").map(&:chars)
        @outputs << parts[1].split(" ").map(&:chars)
      end
      @mappings_to_decode = Array.new(@signals.length, 0)
  end

  def generate_map_for(signal)
    d = Array.new(10)
    d[1] = signal.select { |digit| digit.length == 2 }[0]
    d[4] = signal.select { |digit| digit.length == 4 }[0]
    d[7] = signal.select { |digit| digit.length == 3 }[0]
    d[8] = signal.select { |digit| digit.length == 7 }[0]

    d_2o3o5 = signal.select { |digit| [5].include? digit.length }
    d_6o9o0 = signal.select { |digit| [6].include? digit.length }
    segment_a = (d[7] - d[1])[0]
    d_center_lines = d_2o3o5[0] & d_2o3o5[1] & d_2o3o5[2]
    segment_g = (d_center_lines & d[4])[0]
    segment_f = (d[4] - [segment_g] - d[1])[0]

    d[5] = d_2o3o5.select{ |digit| 
      digit.include? segment_f
    }[0]
    segment_b = (d[1] - d[5])[0]
    segment_c = (d[1] - [segment_b])[0]
    d[3] = d_2o3o5.select{ |digit|
      digit.include? segment_b and digit.include? segment_c 
    }[0]
    d[2] = (d_2o3o5 - [d[3]] - [d[5]])[0]
    d[0] = d_6o9o0.select{ |digit| 
      !digit.include? segment_g
    }[0]
    d[9] = d_6o9o0.select{ |digit| 
      digit.include? segment_b and digit.include? segment_g
    }[0]
    d[6] = (d_6o9o0 - [d[9]] - [d[0]])[0]
    return d.map { |digit| digit.sort.join }
  end

  def decode(map, output)
    res = output.map { |digit| 
      map.find_index(digit.sort.join)
    }.join.to_i
    return res
  end

  def count_unique_digits(digits)
    digits.count { |digit| [2,3,4,7].include? digit.length}
  end

  def solve_part1
    @outputs.each.map { |digits| count_unique_digits(digits) }.sum
  end

  def solve_part2
    sum = 0
    @outputs.each_with_index { |output,i|
      map = generate_map_for(@signals[i])
      sum += decode(map, output)
    }
    return sum
  end
end
