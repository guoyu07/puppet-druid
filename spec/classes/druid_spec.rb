require 'spec_helper'

describe 'druid' do
  context 'supported operating systems' do
    ['Debian'].each do |osfamily|
      describe "druid class without any parameters on #{osfamily}" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
          :lsbdistid => 'Ubuntu',
          :lsbdistcodename => 'trusty',
          :lsbdistrelease => '14.04',
          :puppetversion   => Puppet.version,
        }}

        it { should compile.with_all_deps }

        it { should contain_class('druid') }
        it { should contain_class('druid::install').that_comes_before('druid::config') }
        it { should contain_class('druid::config') }

        it { should contain_user('druid') }
        it { should contain_group('druid') }
        it { should contain_file('common.runtime.properties')\
          .with_path('/opt/imply/conf/druid/_common/common.runtime.properties')
        }
        it { should contain_file('log4j2.xml')\
          .with_path('/opt/imply/conf/druid/_common/log4j2.xml')
        }
      end
    end
  end

end
