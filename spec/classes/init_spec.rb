require 'spec_helper'

describe 'wget' do
  on_supported_os.each do |os,facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      context 'manage_package false' do
        let(:params) do
          {
            :manage_package => false
          }
        end

        it do
          is_expected.not_to contain_package('wget')
        end
      end

      case facts[:kernel]
      when 'Linux'
        context 'version present' do
          it do
            is_expected.to contain_package('wget').with(
              'ensure' => 'present'
            )
          end
        end

        context 'version 1.17.1' do
          let(:params) do
            {
              :version => '1.17.1'
            }
          end

          it do
            is_expected.to contain_package('wget').with(
              'ensure' => '1.17.1'
            )
          end
        end
      when 'FreeBSD'
        if facts[:operatingsystemmajrelease] == '10'
          context 'version present' do
            it do
              is_expected.to contain_package('wget').with(
                'ensure' => 'present'
              )
            end
          end

          context 'version 1.17.1' do
            let(:params) do
              {
                :version => '1.17.1'
              }
            end

            it do
              is_expected.to contain_package('wget').with(
                'ensure' => '1.17.1'
              )
            end
          end
        else
          context 'version present' do
            it do
              is_expected.to contain_package('wget').with(
                'ensure' => 'present',
                'name'   => 'ftp/wget',
                'alias'  => 'wget'
              )
            end
          end

          context 'version 1.17.1' do
            let(:params) do
              {
                :version => '1.17.1'
              }
            end

            it do
              is_expected.to contain_package('wget').with(
                'ensure' => '1.17.1',
                'name'   => 'ftp/wget',
                'alias'  => 'wget'
              )
            end
          end
        end
      else
        it do
          is_expected.not_to contain_package('wget')
        end
      end
    end
  end
end
