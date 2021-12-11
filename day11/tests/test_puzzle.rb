$LOAD_PATH << '.'
require 'test/unit'
require 'puzzle'
class TestPuzzle < Test::Unit::TestCase

    def setup
        @outputs = File.open('outputs_test.txt', "r").readlines.map { |line| line.chomp }
    end

    def test_step0
        d = Puzzle.new("input_test.txt")
        assert_equal @outputs.slice(1,10), d.octopuses
    end

    def test_step1
        d = Puzzle.new("input_test.txt")
        1.times do d.stepforward end
        puts "Sterp1: #{d.octopuses} flashes: #{d.flashes}"
        assert_equal @outputs.slice(13,10), d.octopuses
    end
    def test_step2
        d = Puzzle.new("input_test.txt")
        n = 2
        n.times do d.stepforward end
        puts "Sterp1: #{d.octopuses} flashes: #{d.flashes}"
        assert_equal @outputs.slice(n*12+1,10), d.octopuses
    end
    def test_step10
        d = Puzzle.new("input_test.txt")
        n = 10
        n.times do d.stepforward end
        puts "Sterp1: #{d.octopuses} flashes: #{d.flashes}"
        assert_equal @outputs.slice(n*12+1,10), d.octopuses
    end
    def test_solve1
        d = Puzzle.new("input_test.txt")
        assert_equal 1656, d.solve_part1
    end
    def test_solve2
        d = Puzzle.new("input_test.txt")
        assert_equal 195, d.solve_part2
    end
end