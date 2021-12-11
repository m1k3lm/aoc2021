class Puzzle

    def initialize(filename)
        @inputs = File.open(filename, "r").readlines.map { |line| line.chomp }
    end
    
    def get_digit(inputs, max)
        digits = Array.new(@inputs[0].length) { |i| 0 }
        inputs.each do |input|
            input.chars.each_with_index do |digit, i|
                digits[i]+=digit.to_i if i<inputs[0].length
            end
        end
        treshold = inputs.count/2.0
        if max then
            get_max(digits, treshold)
        else
            get_min(digits, treshold)
        end
    end
    
    def get_max(digits, treshold)
        digits.each.map{ |digit| digit < treshold ? "0" : "1" }
    end
    
    def get_min(digits, treshold)
        digits.each.map { |digit| digit < treshold ? "1" : "0" }
    end

    def solve_part1
        gamma_rate = get_digit(@inputs,true)
        epsilon_rate = get_digit(@inputs,false)
        return gamma_rate.join.to_i(2) * epsilon_rate.join.to_i(2)
    end

    def solve_part2
        ogr = @inputs.clone
        csr = @inputs.clone
        ogr[0].length.times.with_index do |i|
            gr = get_digit(ogr, true)
            ogr.size == 1 ? break : ogr.filter! { |x| x.chars[i] == gr[i] }
        end
        csr[0].length.times.with_index  do |i|
            gr = get_digit(csr, false)
            csr.size == 1 ? break : csr.filter! { |x| x.chars[i] == gr[i] }
        end
        
        return csr.join.to_i(2) * ogr.join.to_i(2)
    end
end