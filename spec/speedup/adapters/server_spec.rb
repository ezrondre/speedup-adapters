require 'securerandom'
require 'speedup/request_data'
require 'speedup/adapters/server'

module Speedup
  module Adapters

    describe Server do
      let(:api_key) { SecureRandom.hex }
      subject { Server.new(url: 'http://external.perfdashboard.cz', api_key: api_key) }

      before(:each) do
        stub_request(:post, "external.perfdashboard.cz/requests.json").
          to_return(:status => [403, "Unauthorized"])

        stub_request(:post, "external.perfdashboard.cz/requests.json").
          with(:headers => { 'X-SUR-API-Key' => api_key })
      end

      context '#write' do
        context 'with right api_key' do
          it 'writes data' do
            request_id = SecureRandom.uuid
            data = Speedup::RequestData.new
            data.storage_for(:request)[:duration] = 10
            connection = subject.write(request_id, data)
            connection.join
            expect(connection.pop.status_code).to eq(200)
          end
        end
        context 'with wrong api_key' do
          it 'does not writes data' do
            subject.instance_variable_set(:"@api_key", 'bad_api_key')
            request_id = SecureRandom.uuid
            data = Speedup::RequestData.new
            data.storage_for(:request)[:duration] = 10
            connection = subject.write(request_id, data)
            connection.join
            expect(connection.pop.status_code).to eq(403)
          end
        end
      end
    end

  end
end
