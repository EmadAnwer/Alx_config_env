# instaling requirements to develop in C


# install build-essential
package{'build-essential':
  ensure => 'installed',
}

# install git
package{'git':
  ensure => 'installed',
}

# clone Betty repo
vcsrepo { '/root/Alx_config_env/Betty':
  ensure   => 'present',
  provider => git,
  source   => 'https://github.com/alx-tools/Betty',
  require  => Package['git']
}

# install betty
exec{'install betty':
        command => '/usr/bin/sudo /root/Alx_config_env/Betty/install.sh',
        path    => ['/usr/bin','/usr/sbin','/bin'],
        require => Vcsrepo['/root/Alx_config_env/Betty'],
}

# Read content from a file and assign it to a variable
$betty_file_content = file('/root/Alx_config_env/betty')

# Create betty file in /bin to allow betty to be run from anywhere
file{'/bin/betty':
  ensure => 'present',
  content => $betty_file_content,
  mode   => '0755',
  require => Exec['install betty'],
}
