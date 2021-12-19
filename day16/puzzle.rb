require 'classes/Packet'
require 'classes/PacketLiteral'
require 'classes/PacketOperator'

class Puzzle
    attr_accessor :bits, :packet
    def initialize(filename)
        File.exist?(filename) ? @input_data = File.read(filename).chomp : @input_data = filename
        @bits = get_bits
        parse_input
    end

    def get_bits
        @bits = @input_data.to_i(16).to_s(2).chars
        leading_0 = @input_data.length * 4 - @bits.length
        leading_0.times do |i|
            @bits.unshift('0')
        end
        @bits
    end

    def parse_input
        type = Packet.get_type_for_bits(bits)
        @packet = PacketLiteral.new(bits) if type == 'PacketLiteral'
        @packet = PacketOperator.new(bits) if type == 'PacketOperator'
    end

    def solve_part1
        @packet.get_cumultive_version
    end

    def solve_part2
        return @packet.to_i
    end
end
