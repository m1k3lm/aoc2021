$LOAD_PATH << '.'
require 'test/unit'
require 'puzzle'
class TestPuzzle < Test::Unit::TestCase
    def test_enhance_char
        d = Puzzle.new("input_test.txt")
        assert_equal '#', d.enhance_char(4,4,d.initial_input_img,0)
        assert_equal '.', d.enhance_char(0,0,d.initial_input_img,0)
        assert_equal '.', d.enhance_char(6,6,d.initial_input_img,0)
        assert_equal '#', d.enhance_char(5,6,d.initial_input_img,0)
        assert_equal '#', d.enhance_char(6,5,d.initial_input_img,0)
    end
    def test_solve1
        d = Puzzle.new("input_test.txt")
        assert_equal 35, d.solve_part1
    end
    def test_solve2
        d = Puzzle.new("input_test.txt")
        assert_equal 3351, d.solve_part2
    end
end