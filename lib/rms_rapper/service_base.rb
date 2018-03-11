require 'rms_rapper/result'

module RmsRapper
  class ServiceBase
    class << self
      include RmsRapper::Result

      private

      def client
        RmsRapper.configration
      end

      def request(header, params)
        { header => { item: params } }.to_xml(root: 'request',
                                              camelize: :lower,
                                              skip_types: true)
      end

      def symbolize_keys(hash)
        hash.map do |k, v|
          [k.to_sym, v]
        end.to_h
      end
    end
  end
end
