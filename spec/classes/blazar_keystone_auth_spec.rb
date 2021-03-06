#
# Unit tests for blazar::keystone::auth
#

require 'spec_helper'

describe 'blazar::keystone::auth' do
  shared_examples_for 'blazar-keystone-auth' do
    context 'with default class parameters' do
      let :params do
        { :password => 'blazar_password',
          :tenant   => 'foobar' }
      end

      it { is_expected.to contain_keystone_user('blazar').with(
        :ensure   => 'present',
        :password => 'blazar_password',
      ) }

      it { is_expected.to contain_keystone_user_role('blazar@foobar').with(
        :ensure  => 'present',
        :roles   => ['admin']
      )}

      it { is_expected.to contain_keystone_service('blazar::reservation').with(
        :ensure      => 'present',
        :description => 'Blazar Reservation Service'
      ) }

      it { is_expected.to contain_keystone_endpoint('RegionOne/blazar::baremetal').with(
        :ensure       => 'present',
        :public_url   => 'http://127.0.0.1:1234',
        :admin_url    => 'http://127.0.0.1:1234',
        :internal_url => 'http://127.0.0.1:1234',
      ) }
    end

    context 'when overriding URL parameters' do
      let :params do
        { :password     => 'blazar_password',
          :public_url   => 'https://10.10.10.10:80',
          :internal_url => 'http://10.10.10.11:81',
          :admin_url    => 'http://10.10.10.12:81', }
      end

      it { is_expected.to contain_keystone_endpoint('RegionOne/blazar::reservation').with(
        :ensure       => 'present',
        :public_url   => 'https://10.10.10.10:80',
        :internal_url => 'http://10.10.10.11:81',
        :admin_url    => 'http://10.10.10.12:81',
      ) }
    end

    context 'when overriding auth name' do
      let :params do
        { :password => 'foo',
          :auth_name => 'blazary' }
      end

      it { is_expected.to contain_keystone_user('blazary') }
      it { is_expected.to contain_keystone_user_role('blazary@services') }
      it { is_expected.to contain_keystone_service('blazar::reservation') }
      it { is_expected.to contain_keystone_endpoint('RegionOne/blazar::reservation') }
    end

    context 'when overriding service name' do
      let :params do
        { :service_name => 'blazar_service',
          :auth_name    => 'blazar',
          :password     => 'blazar_password' }
      end

      it { is_expected.to contain_keystone_user('blazar') }
      it { is_expected.to contain_keystone_user_role('blazar@services') }
      it { is_expected.to contain_keystone_service('blazar_service::reservation') }
      it { is_expected.to contain_keystone_endpoint('RegionOne/blazar_service::reservation') }
    end

    context 'when disabling user configuration' do

      let :params do
        {
          :password       => 'blazar_password',
          :configure_user => false
        }
      end

      it { is_expected.not_to contain_keystone_user('blazar') }
      it { is_expected.to contain_keystone_user_role('blazar@services') }
      it { is_expected.to contain_keystone_service('blazar::reservation').with(
        :ensure      => 'present',
        :description => 'Blazar Reservation Service'
      ) }

    end

    context 'when disabling user and user role configuration' do

      let :params do
        {
          :password            => 'blazar_password',
          :configure_user      => false,
          :configure_user_role => false
        }
      end

      it { is_expected.not_to contain_keystone_user('blazar') }
      it { is_expected.not_to contain_keystone_user_role('blazar@services') }
      it { is_expected.to contain_keystone_service('blazar::reservation').with(
        :ensure      => 'present',
        :description => 'Blazar Reservation Service'
      ) }

    end

    context 'when using ensure absent' do

      let :params do
        {
          :password => 'blazar_password',
          :ensure   => 'absent'
        }
      end

      it { is_expected.to contain_keystone__resource__service_identity('blazar').with_ensure('absent') }

    end
  end

  on_supported_os({
    :supported_os => OSDefaults.get_supported_os
  }).each do |os,facts|
    context "on #{os}" do
      let (:facts) do
        facts.merge!(OSDefaults.get_facts())
      end

      it_behaves_like 'blazar-keystone-auth'
    end
  end
end
