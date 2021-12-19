class Packet
    attr_accessor :bits, :version, :type_id, :sub_packets, :literal, :header, :body
    def Packet.get_type_for_bits(bits)
        type = bits[3..5].join.to_i(2)
        return 'PacketLiteral' if type == 4
        return 'PacketOperator'
        parse
    end

    def initialize(bits)
        @bits = bits
        @bits.freeze
        @type_id = bits[3..5].join.to_i(2)
        @sub_packets = []
        @version = get_version
        @header = bits[0..5]
        parse
    end

    def parse
    end

    def get_version
        @bits[0..2].join.to_i(2)
    end

    def get_cumultive_version
        @sub_packets.each.sum { |p| p.get_cumultive_version }  + @version
    end
end