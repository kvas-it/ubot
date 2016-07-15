require "vagrant"

# https://www.vagrantup.com/docs/vagrantfile/version.html
VAGRANT_API_VERSION = "2"

# https://www.vagrantup.com/docs/vagrantfile/tips.html
ENV["LC_ALL"] = "en_US.UTF-8"

# https://www.vagrantup.com/
Vagrant.configure(VAGRANT_API_VERSION) do |config|

  # https://www.vagrantup.com/docs/multi-machine/
  config.vm.define "ubot" do |config|

    # https://www.vagrantup.com/docs/vagrantfile/machine_settings.html
    config.vm.hostname = "ubot.test"
    config.vm.post_up_message = "http://10.8.10.8:8080/"

    # https://www.vagrantup.com/docs/boxes.html
    config.vm.box = "debian/contrib-jessie64"
    config.vm.box_url = "https://atlas.hashicorp.com/debian/boxes/contrib-jessie64"

    # https://www.vagrantup.com/docs/provisioning/shell.html
    config.vm.provision "shell", path: "provisioning/ubot.sh"

    # https://www.vagrantup.com/docs/networking/
    config.vm.network "private_network", ip: "10.8.10.8"

  end

  # https://github.com/mitchellh/vagrant/issues/1673
  config.ssh.shell = "sh -c 'BASH_ENV=/etc/profile exec bash'"

end
