require 'spec_helper'
require 'rms_rapper'

RSpec.describe RmsRapper do
  before do
    RmsRapper.configration do |c|
      c.service_secret = 'your_secret'
      c.license_key = 'your_license'
    end
  end

  describe 'rms_rapper#item' do
    xit 'item#get' do
      RmsRapper::Item.get('url')
    end

    xit 'item#search' do
      RmsRapper::Item.search(parameter)
    end

    xit 'item#update' do
      result = RmsRapper::Item.update(parameter)
    end

    xit 'item#delete' do
      puts RmsRapper::Item.delete('id').status.systemStatus
    end
  end
end
