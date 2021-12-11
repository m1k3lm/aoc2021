class Puzzle
    def initialize(filename)
        @flumes = []
        inputs = File.open(filename, "r").readlines.map { |line| line.chomp }
        inputs.each do |input|
            ps = input.split(" -> ")
            @flumes << Flume.new(ps[0].split(",").map(&:to_i), ps[1].split(",").map(&:to_i))
        end
    end

    def flumes_max_x
        @flumes.map{|flume| [flume.pfx,flume.pix].max}.max
    end
    def flumes_max_y
      @flumes.map{|flume| [flume.pfy,flume.piy].max}.max
    end

    def solve_part1
        matrix = Array.new(self.flumes_max_x+1) { Array.new(self.flumes_max_y+1, 0) }
        @flumes.each do |flume|
            if flume.horizontal?
              ps = [flume.pix,flume.pfx]
              (ps.min..ps.max).each do |x|
                    matrix[x][flume.piy] += 1
                end
            end 
            if flume.vertical?
              ps = [flume.piy,flume.pfy]
              (ps.min..ps.max).each do |y|
                  matrix[flume.pix][y] += 1
              end
            end
        end
        return matrix.flatten.select{|x| x > 1}.count()
    end

    def solve_part2
        matrix = Array.new(self.flumes_max_x+1) { Array.new(self.flumes_max_y+1, 0) }
        @flumes.each do |flume|
            if flume.horizontal?
              ps = [flume.pix,flume.pfx]
              (ps.min..ps.max).each do |x|
                    matrix[x][flume.piy] += 1
                end
            end 
            if flume.vertical?
              ps = [flume.piy,flume.pfy]
              (ps.min..ps.max).each do |y|
                  matrix[flume.pix][y] += 1
              end
            end
            if !flume.line?
              psx = [flume.pix,flume.pfx]
              stepy = 1
              stepx = 1
              if flume.piy > flume.pfy
                stepy= -1
              end
              if flume.pix > flume.pfx
                stepx= -1
              end
              (1+psx.max-psx.min).times do |i|
                y = flume.piy+i*stepy
                x = flume.pix+i*stepx
                matrix[x][y] += 1
              end
            end
        end
        return matrix.sum{|n| n.count{|x| x > 1}}
    end
end

class Flume
  def initialize(pi,pf)
    @pi = pi
    @pf = pf
  end

  def line?
    @pi[0] == @pf[0] || @pi[1] == @pf[1]
  end
  def vertical?
    @pi[0] == @pf[0]
  end
  def horizontal?
    @pi[1] == @pf[1]
  end
  def pix
    @pi[0]
  end
  def piy
    @pi[1]
  end
  def pfx
    @pf[0]
  end
  def pfy
    @pf[1]
  end
end