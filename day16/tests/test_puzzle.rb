$LOAD_PATH << '.'
require 'test/unit'
require 'puzzle'
class TestPuzzle < Test::Unit::TestCase
    def test_get_bits
        d = Puzzle.new("input_test.txt")
        assert_equal "110100101111111000101000", d.get_bits.join
        d = Puzzle.new("input_test_operator_lt0.txt")
        assert_equal "00111000000000000110111101000101001010010001001000000000", d.get_bits.join
        d = Puzzle.new("input_test1.txt")
        assert_equal "01100010000000001000000000000000000101100001000101010110001011001000100000000010000100011000111000110100", d.get_bits.join
    end

    def test_get_type_for_bits
        assert_equal "PacketLiteral", Packet.get_type_for_bits("110100101111111000101000".chars)
        assert_equal "PacketOperator", Packet.get_type_for_bits("110110101111111000101000".chars)
    end

    def test_get_version
        d = Puzzle.new("input_test.txt")
        assert_equal 6, d.packet.version
        d = Puzzle.new("input_test1.txt")
        assert_equal 3, d.packet.version
    end

    def test_parse_literal
        d = Puzzle.new("input_test.txt")
        assert_equal 2021, d.packet.literal
    end

    def test_parse_operator_lt0
        d = Puzzle.new("input_test_operator_lt0.txt")
        assert_equal 2, d.packet.sub_packets.length
        d = Puzzle.new("input_test1.txt")
        assert_equal 2, d.packet.sub_packets.length
    end

    def test_parse_operator_lt1
        d = Puzzle.new("input_test_operator_lt1.txt")
        assert_equal 3, d.packet.sub_packets.length
    end

    def test_solve1
        d = Puzzle.new("input_test0.txt")
        assert_equal 16, d.solve_part1
        d = Puzzle.new("input_test1.txt")
        assert_equal 12, d.solve_part1
        d = Puzzle.new("input_test2.txt")
        assert_equal 23, d.solve_part1
        d = Puzzle.new("input_test3.txt")
        assert_equal 31, d.solve_part1
    end

    def test_solve2
        d = Puzzle.new("C200B40A82")# finds the sum of 1 and 2, resulting in the value 3.
        assert_equal 3, d.solve_part2
        d = Puzzle.new("04005AC33890")# finds the product of 6 and 9, resulting in the value 54.
        assert_equal 54, d.solve_part2
        d = Puzzle.new("880086C3E88112")# finds the minimum of 7, 8, and 9, resulting in the value 7.
        assert_equal 7, d.solve_part2
        d = Puzzle.new("CE00C43D881120")# finds the maximum of 7, 8, and 9, resulting in the value 9.
        assert_equal 9, d.solve_part2
        d = Puzzle.new("D8005AC2A8F0")# produces 1, because 5 is less than 15.
        assert_equal 1, d.solve_part2
        d = Puzzle.new("F600BC2D8F")# produces 0, because 5 is not greater than 15.
        assert_equal 0, d.solve_part2
        d = Puzzle.new("9C005AC2F8F0")# produces 0, because 5 is not equal to 15.
        assert_equal 0, d.solve_part2
        d = Puzzle.new("9C0141080250320F1802104A08")# produces 1, because 1 + 3 = 2 * 2.
        assert_equal 1, d.solve_part2
    end
end
