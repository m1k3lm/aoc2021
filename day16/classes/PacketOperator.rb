class PacketOperator < Packet
    DATA_OFFSET = 7
    LENGTH_TYPE_LENGTH = {"0"=>15,"1"=>11}

    def parse
        @sub_packets = []
        @length_type_id = @bits[6]
        @header=@bits[0..get_packets_offset-1]
        parse_subpackets_by_length if @length_type_id == "0"
        parse_subpackets_by_qty if @length_type_id == "1"
    end

    def parse_subpackets_by_length
        length = @bits[DATA_OFFSET..get_packets_offset-1].join.to_i(2)
        @body = @bits[get_packets_offset..get_packets_offset+length-1]
        @body.freeze
        s = @body.dup
        while !s.nil? && s.length > PacketLiteral::DATA_OFFSET do
            s = build_packets(s)
        end
    end

    def parse_subpackets_by_qty
        qty = @bits[DATA_OFFSET..get_packets_offset-1].join.to_i(2)
        s = @bits[get_packets_offset..-1]
        qty.times do |i|
            s = build_packets(s)
        end
        @body = @bits[get_packets_offset..get_packet_end-1]
    end

    def get_packet_end
        get_packets_offset + @sub_packets.sum{|p| p.get_packet_length}
    end

    def get_packet_length
        @header.length + @body.length
    end

    def reminder
        @bits[get_packet_end..-1]
    end

    def build_packets(s)
        type = Packet.get_type_for_bits(s)
        packet = PacketLiteral.new(s) if type == 'PacketLiteral'
        packet = PacketOperator.new(s) if type == 'PacketOperator'
        @sub_packets << packet
        packet.reminder
    end

    def get_packets_offset
        DATA_OFFSET + LENGTH_TYPE_LENGTH[@length_type_id]
    end

    def to_i
        case @type_id
        when 0
            return @sub_packets.sum{|p| p.to_i}
        when 1
            return @sub_packets.reduce(1){|c,p| c * p.to_i}
        when 2
            return @sub_packets.map{|p| p.to_i}.min
        when 3
            return @sub_packets.map{|p| p.to_i}.max
        when 5
            return 1 if @sub_packets[0].to_i > @sub_packets[1].to_i
        when 6
            return 1 if @sub_packets[0].to_i < @sub_packets[1].to_i
        when 7
            return 1 if @sub_packets[0].to_i == @sub_packets[1].to_i    
        end
        return 0
    end
end
