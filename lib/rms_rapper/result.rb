module RmsRapper
  module Result
    class ResultBase
      def initialize(data)
        data.each do |key, value|
          ItemResult.class_eval do
            attr_accessor key.to_sym
          end
          send((key + '=').to_sym, value)
        end
      end
    end

    class ItemResult < ResultBase; end
    class ErrorMessageResult < ResultBase; end

    attr_accessor :interfaceId, :systemStatus, :message, :errorMessage,
                  :requestId, :requests, :code, :numFound, :items, :item
    def result(xml)
      result = Hash.from_xml(xml)['result'].to_a
      result[0][1].merge(result[1][1]).each do |key, value|
        case key
        when 'items'
          tmp = []
          value['item'].each do |item|
            tmp.push(ItemResult.new(item))
          end
          value = tmp
        when 'item'
          value = ItemResult.new(value)
        when 'errorMessage'
          value = ErrorMessageResult.new(value)
        end
        send((key + '=').to_sym, value)
      end

      self
    end
  end
end
