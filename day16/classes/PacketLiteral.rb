class PacketLiteral < Packet
    DATA_OFFSET = 6
    def parse
        @body = @bits[DATA_OFFSET..get_packet_end]
        @literal = @body.each_slice(5).
            filter {|s|s.length == 5}.
            map { |s| s[1..4] if s.length==5 }.
            join.to_i(2)
    end

    def get_packet_end
        (DATA_OFFSET..@bits.length-1).step(5) do |b|
            return b+4 if @bits[b]=="0"
        end 
    end
    
    def to_i
        @literal
    end
    
    def get_packet_length
        @header.length + @body.length
    end

    def reminder
        @bits[get_packet_length..-1]
    end
end