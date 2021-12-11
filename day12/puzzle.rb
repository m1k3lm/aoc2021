class Puzzle
    attr_accessor :nodes, :paths

    def initialize(filename)
        inputs = File.open(filename, "r").readlines.map { |line| line.chomp }
        @nodes= {}
        inputs.each do |input|
            nodes = input.split("-")
            @nodes[nodes[0]] ||= Node.new(nodes[0])
            @nodes[nodes[1]] ||= Node.new(nodes[1])
            @nodes[nodes[0]].add_node(@nodes[nodes[1]])
            @nodes[nodes[1]].add_node(@nodes[nodes[0]])
        end
    end

    def build_paths(path, node)
        node.nodes.select { |k,n| n.visitable_in_path? path }.each do |k,n|
            next_path = Path.new(path.nodes.dup)
            next_path.add_node(n)
            if n.type != "end"
                build_paths(next_path, n)
            else
                @paths << next_path
            end
        end
    end

    def build_paths_with_dup(path, node)
        node.nodes.select { |k,n| n.visitable_with_dup? path }.each do |k,n|
            next_path = Path.new(path.nodes.dup)
            next_path.add_node(n)
            if n.type != "end"
                build_paths_with_dup(next_path, n)
            else
                @paths << next_path
            end
        end
    end

    def solve_part1
        @paths = []
        build_paths(Path.new([@nodes['start']]), @nodes['start'])
        return @paths.length
    end

    def solve_part2
        @paths = []
        build_paths_with_dup(Path.new([@nodes['start']]), @nodes['start'])
        return @paths.length
    end
end

class Node
    attr_accessor :name, :nodes, :type

    def initialize(name)
        @name = name
        case name
        when 'start' 
            @type = 'start'
        when 'end' 
            @type = 'end'
        when /[A-Z]+/ 
            @type = 'big'
        when /[a-z]+/
            @type = 'small'
        end
        @nodes = {}
        @visited = false
    end

    def add_node(node)
        @nodes[node.name] = node
    end

    def visitable_in_path? path
        @type == 'big' || !path.include?(self)
    end

    def visitable_with_dup? path
        @type == 'big' ||
        !path.include?(self) ||
        (@type == 'small' && !small_dup?(path))
    end

    def small_dup? path
        map = {}
        path.nodes.select { |n| n.type == 'small' }.each do |v|
          map[v.name] = (map[v.name] || 0 ) + 1
          if map[v.name] > 1
            return true
          end
        end
        return false
    end
end

class Path
    attr_accessor :nodes

    def initialize(nodes)
        @nodes = nodes
    end

    def add_node(node)
        @nodes.push node
    end

    def last_node
        @nodes.last
    end

    def include?(node)
        @nodes.include? node
    end

    def to_s
        @nodes.map {|n| n.name}.join(',')
    end
end
