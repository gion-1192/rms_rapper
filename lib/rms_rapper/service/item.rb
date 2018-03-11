module RmsRapper
  class Item < ServiceBase
    ENDPOINT = 'https://api.rms.rakuten.co.jp/es/1.0/item'.freeze

    class << self
      def get(id)
        result(client.rms_get(self, itemUrl: id))
      end

      def search(params = {})
        result(client.rms_get(self, params))
      end

      def insert(params = {})
        result(client.rms_post(self, request(:itemInsertRequest, params)))
      end

      def update(params = {})
        result(client.rms_post(self, request(:itemUpdateRequest, params)))
      end

      def delete(id)
        result(client.rms_post(self, request(:itemDeleteRequest, itemUrl: id)))
      end
    end
  end
end
