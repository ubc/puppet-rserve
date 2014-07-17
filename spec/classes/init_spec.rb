require 'spec_helper'
describe 'rserve' do
  let(:facts) {{:osfamily => 'RedHat', :root_home => '/root'}}

  context 'with defaults for all parameters' do
    it {
      should contain_class('rserve')
      should contain_class('r')
      should contain_class('rserve::service').with(
        'service_enable' => true,
        'service_ensure' => 'running',
      )
      should contain_service('rserve').with_ensure('running')
      should contain_file('rserve')

      should contain_firewall('150 allow Rserve connection').with_port('6311')
    }

  end

  context 'without firewall' do
    let(:params) do 
        { :manage_firewall => false }
    end

    it {
      should_not contain_firewall('150 allow Rserve connection').with_port('6311')
    }

  end
end
