# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfileのあるディレクトリ
$basedir = File.dirname(__FILE__)

# .vagrantの存在チェック
def firstrun?
  ! File.exist? "#{$basedir}/.vagrant"
end

Vagrant::Config.run do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.define :ubuntu_12_04 do |c|

    c.vm.box = "ubuntu_12_04"
    # The url from where the 'c.vm.box' box will be fetched if it
    # doesn't already exist on the user's system.
    # c.vm.box_url = "http://domain.com/path/to/above.box"
    c.vm.box_url = "http://files.vagrantup.com/precise64.box"

    # Boot with a GUI so you can see the screen. (Default is headless)
    # c.vm.boot_mode = :gui

    # Assign this VM to a host-only network IP, allowing you to access it
    # via the IP. Host-only networks can talk to the host machine as well as
    # any other machines on the same network, but cannot be accessed (through this
    # network interface) by any external networks.
    # c.vm.network :hostonly, "192.168.33.10"
    c.vm.network :hostonly, "192.168.33.10"

    # Assign this VM to a bridged network, allowing you to connect directly to a
    # network using the host's network device. This makes the VM appear as another
    # physical device on your network.
    # c.vm.network :bridged

    # Forward a port from the guest to the host, which allows for outside
    # computers to access the VM, whereas host only networking does not.
    # c.vm.forward_port 80, 8080

    # Share an additional folder to the guest VM. The first argument is
    # an identifier, the second is the path on the guest to mount the
    # folder, and the third is the path on the host to the actual folder.
    # c.vm.share_folder "v-data", "/vagrant_data", "../data"

    # Enable provisioning with Puppet stand alone.  Puppet manifests
    # are contained in a directory path relative to this Vagrantfile.
    # You will need to create the manifests directory and a manifest in
    # the file ubuntu-server-12.04.pp in the manifests_path directory.
    #
    # An example Puppet manifest to provision the message of the day:
    #
    # # group { "puppet":
    # #   ensure => "present",
    # # }
    # #
    # # File { owner => 0, group => 0, mode => 0644 }
    # #
    # # file { '/etc/motd':
    # #   content => "Welcome to your Vagrant-built virtual machine!
    # #               Managed by Puppet.\n"
    # # }
    #
    # c.vm.provision :puppet do |puppet|
    #   puppet.manifests_path = "manifests"
    #   puppet.manifest_file  = "ubuntu-server-12.04.pp"
    # end

    # Enable provisioning with chef solo, specifying a cookbooks path, roles
    # path, and data_bags path (all relative to this Vagrantfile), and adding
    # some recipes and/or roles.
    #
    c.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = "cookbooks"
      # .vagrantが存在しない=初回起動
      # だったらレシピ「dummy」を実行
      # 2回目以降だったらレシピ「web」を実行
      # c.vm.provision
      if firstrun?
        chef.run_list = "recipe[dummy]"
      else
        chef.run_list = "recipe[dummy]"
      end
      # chef.roles_path = "roles"
      # chef.data_bags_path = "data_bags"
      # chef.add_recipe "mysql"
      # chef.add_role "web"

      # You may also specify custom JSON attributes:
      # chef.json = { :mysql_password => "foo" }
    end

    # Enable provisioning with chef server, specifying the chef server URL,
    # and the path to the validation key (relative to this Vagrantfile).
    #
    # The Opscode Platform uses HTTPS. Substitute your organization for
    # ORGNAME in the URL and validation key.
    #
    # If you have your own Chef Server, use the appropriate URL, which may be
    # HTTP instead of HTTPS depending on your configuration. Also change the
    # validation key to validation.pem.
    #
    # c.vm.provision :chef_client do |chef|
    #   chef.chef_server_url = "https://api.opscode.com/organizations/ORGNAME"
    #   chef.validation_key_path = "ORGNAME-validator.pem"
    # end
    #
    # If you're using the Opscode platform, your validator client is
    # ORGNAME-validator, replacing ORGNAME with your organization name.
    #
    # IF you have your own Chef Server, the default validation client name is
    # chef-validator, unless you changed the configuration.
    #
    #   chef.validation_client_name = "ORGNAME-validator"

    c.vm.customize do |v|
      v.memory_size = 512
    end

  end
end
