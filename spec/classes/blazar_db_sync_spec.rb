require 'spec_helper'

describe 'blazar::db::sync' do

  shared_examples_for 'blazar-dbsync' do

    it 'runs blazar-db-sync' do
      is_expected.to contain_exec('blazar-db-sync').with(
        :command     => 'blazar-db-manage upgrade head ',
        :path        => [ '/bin', '/usr/bin', ],
        :refreshonly => 'true',
        :user        => 'blazar',
        :logoutput   => 'on_failure'
      )
    end

  end

  on_supported_os({
    :supported_os   => OSDefaults.get_supported_os
  }).each do |os,facts|
    context "on #{os}" do
      let (:facts) do
        facts.merge(OSDefaults.get_facts({
          :os_workers     => 8,
          :concat_basedir => '/var/lib/puppet/concat'
        }))
      end

      it_configures 'blazar-dbsync'
    end
  end

end
