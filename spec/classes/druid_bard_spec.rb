require 'spec_helper'

describe 'druid::bard' do
  context 'supported operating systems' do
    ['Debian'].each do |osfamily|
      describe "druid class without any parameters on #{osfamily}" do
        let(:params) {{ }}
        let :facts do
          {
            :lsbdistrelease  => '14.04',
            :lsbdistcodename => 'trusty',
            :operatingsystem => 'Ubuntu',
            :osfamily        => 'Debian',
            :lsbdistid       => 'Ubuntu',
            :puppetversion   => Puppet.version,
          }
        end

        it { should compile.with_all_deps }

        it { should contain_class('druid::bard') }
        it { should contain_class('druid::bard::install').that_comes_before('druid::bard::config') }
        it { should contain_class('druid::bard::config').that_notifies('druid::bard::service') }
        it { should contain_class('druid::bard::service') }

      end
    end
  end

end
