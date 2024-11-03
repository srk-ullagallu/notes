Four Golden Signals **Latency** **Traffic** **Errors** **Saturation**
 
# 2-9-24

APM [Application performance Monitoring]

we want analyze what is going on with app wheather app serving very well or not well

with monitoring we will understand behaviour of the application

Newlic is a end to end paid monitoring tool[metrics,logging,traces]

Application performacne monitoring tool[newrelic]

new relic is where dev,ops,security and business teams solve software performance problems with data

Google SRE book[https://sre.google/sre-book/monitoring-distributed-systems/]

Four Golden Singnals

Latency,Traffic,Errors,Saturation

# 3-9-24
you're always look into recent data not  very long data

TSDB based on you can get the data based on graph you represent

If you very long data db ops could be slowed

maintainning static config is very difficult

ec2_sd_config

```yaml
job_name: "ec2-discovery"
    ec2_sd_configs:
        - region: ap-south-1
          port: 9100
          filters:
            - name: 'tag:Monitor'
              values: ['true','yes']
    relabel_configs:
        - source_labels: [_meta_ec2_tag_name]
          target_label: name
```
every point of time of you have value

Singnificant increase in the performance persfective

for long term storage prometheus is a not great solution you need to rely on other tools

2weeks data it will keep

exporters like metric collectors

- Node Exporter[collect the the metrics from vm]
- Kube state metrics[collects metrics from kube-apiserver]
- mysql exporter[collects metrics from mysql]
- mongo

static configuration pain to add each and every 
- Monitor EC2 instance dynamically

auto discovery

prometheus = data collector
grafana = visualizer

https://pages.awscloud.com/GLOBAL_NCA_LN_ARRC-program-A300-2023.html

kube prometheus stack

`operator` it help us do some custom updates 

external dns k8s 

# 4-9-2024

kuberenetes sigs

# 5-9-24

curl -v http://<ip>:<port>

# 6-9-24

