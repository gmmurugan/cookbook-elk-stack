#Test Metrics Backend

This is an attempt to create infrastructure that will allow us to easily visualize test metrics.

The solution at the moment is elasticsearch with kibana running on a single Ubuntu node for data storage and visualization.

The data feed can come from a logstash instance or by implementing data push plugins in our CI infrastructure.


## Developing the solution

You need vagrant, VMWare Workstation and the vagrant VMWare plugin.

Using [linux-developer-vm](https://github.com/Zuehlke/linux-developer-vm) as the basis with different cookbooks.

## Testing

Testing is done via serverspec.

## Access

Elasticsearch is accessible via portforwarding through http://127.0.0.1:9200/ . Also the elasticsearch-head plugin
is installed, which you can find under http://127.0.0.1:9200/_plugin/head . 
Kibana can be reached under http://127.0.0.1:8080 .

## Elasticsearch data

This vm comes preconfigured with a logstash config for feeding
elasticsearch with the logfiles of this vm. Adjust these accordingly.
Have a look at cookbooks/vm/templates/default/logstash/ .
