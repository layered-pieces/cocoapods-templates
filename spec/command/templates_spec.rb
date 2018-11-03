require File.expand_path('../../spec_helper', __FILE__)

module Pod
  describe Command::Templates do
    describe 'CLAide' do
      it 'registers it self' do
        Command.parse(%w{ templates }).should.be.instance_of Command::Templates
      end
    end
  end
end

