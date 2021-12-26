class Puzzle
    attr_reader :initial_input_img
    def initialize(filename)
        inputs = File.open(filename, "r").readlines.map { |line| line.chomp }
        @algorithm = inputs[0].chars
        @initial_input_img = inputs[2..inputs.length-1].map(&:chars)
        @initial_input_img.freeze
        @algorithm.freeze
        @offset = 1
    end

    def enhance_char y, x, input_img, i
        number = []
        (y-@offset-1..y-@offset+1).each do |dy|
            (x-@offset-1..x-@offset+1).each do |dx|
                (number << "0" && next) if (dy<0 || dx<0 || dy>input_img.length-1 || dx>input_img.length-1) && @algorithm[0] == "."
                (number << "1" && next) if (dy<0 || dx<0 || dy>input_img.length-1 || dx>input_img.length-1) && @algorithm[0] == "#" && i%2 == 0
                (number << "0" && next) if (dy<0 || dx<0 || dy>input_img.length-1 || dx>input_img.length-1) && @algorithm[0] == "#" && i%2 == 1
                (number << "1" && next) if input_img[dy][dx]=="#"
                (number << "0" && next) if input_img[dy][dx]=="."
            end
        end
        @algorithm[number.join.to_i(2)]
    end

    def enhance input_img, i
        output_img = Array.new(input_img.length+2*@offset){Array.new(input_img[0].length+2*@offset,'.')}
        for y in 0..output_img.length-1
            for x in 0..output_img[y].length-1
                output_img[y][x] = enhance_char y, x, input_img, i
            end
        end
        #plot output_img
        output_img
    end

    def plot input_img
        input_img.each do |row|
            puts row.join
        end
    end

    def solve_part1
        @offset = 2
        @iterations = 2
        img = @initial_input_img.dup
        (1..@iterations).each do |i|
            img = enhance(img,i)
        end
        frame_width = @iterations*(@offset-1)
        img =  img[frame_width..-(frame_width+1)].map{|r| r[frame_width..-(frame_width+1)]}
        plot img
        img.flatten.count("#")
    end

    def solve_part2
        @offset = 2
        @iterations = 50
        img = @initial_input_img.dup
        (1..@iterations).each do |i|
            img = enhance(img,i)
        end
        frame_width = @iterations*(@offset-1)
        img =  img[frame_width..-(frame_width+1)].map{|r| r[frame_width..-(frame_width+1)]}
        plot img
        img.flatten.count("#")
    end
end