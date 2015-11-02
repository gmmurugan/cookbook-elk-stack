# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  if Vagrant.has_plugin?("berkshelf")
    config.berkshelf.enabled=false
  end
  
  config.vm.define "elastic-test" do |cfg| 
    config.vm.box = "boxcutter/ubuntu1404"
    cfg.vm.hostname="elastic-test"
    cfg.vm.box_check_update = true
    # Port forward SSH
    cfg.vm.network :forwarded_port, guest: 22, host: 2223, id: "ssh", auto_correct:true
    cfg.vm.network :forwarded_port, guest: 9200, host: 9200, id: "elastic", auto_correct:true
    cfg.vm.network :forwarded_port, guest: 80, host: 8080, id: "elastic", auto_correct:true

    cfg.vm.provider :virtualbox do |vbox, override|
      vbox.customize ["modifyvm", :id,
                      "--name", "elastic-test",
                      "--memory", 4096,
                      "--cpus", 2
      ]
    end

    cfg.vm.provider :vmware_workstation do |v, override|
      v.gui = true
      v.vmx["memsize"] = "4096"
      v.vmx["numvcpus"] = "1"
      v.vmx["cpuid.coresPerSocket"] = "2"
      v.vmx["ethernet0.virtualDev"] = "vmxnet3"
      v.vmx["RemoteDisplay.vnc.enabled"] = "false"
      v.vmx["RemoteDisplay.vnc.port"] = "5900"
      v.vmx["scsi0.virtualDev"] = "lsilogic"
    end

    cfg.vm.provision "shell", privileged: false, inline: "/vagrant/scripts/update-vm.sh"
  end
 
  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

end
