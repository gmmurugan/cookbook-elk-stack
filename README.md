#Test Metrics Backend

This is an attempt to create infrastructure that will allow us to easily visualize test metrics.

The solution at the moment is elasticsearch with kibana running on a single Ubuntu node for data storage and visualization.

The data feed can come from a logstash instance or by implementing data push plugins in our CI infrastructure.


## Developing the solution

You need vagrant, VMWare Workstation and the vagrant VMWare plugin or VirtualBox.

Using [linux-developer-vm](https://github.com/Zuehlke/linux-developer-vm) as the basis with the [elasticsearch](https://github.com/elastic/cookbook-elasticsearch) cookbook.
