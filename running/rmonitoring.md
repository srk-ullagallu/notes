
# Obseevability[newrelic,prometheus&grafana,Elastic Stack]
Four Golden Signals **Latency** **Traffic** **Errors** **Saturation**
 
# 2-9-24

APM [Application performance Monitoring]

we want analyze what is going on with app wheather app serving very well or not well

with monitoring we will understand behaviour of the application

Newlic is a end to end paid monitoring tool[metrics,logging,traces]

Application performacne monitoring tool[newrelic] all apm tools are too much costly

One tool for everything = new relic no need prometheus,grafana,elastic stack and kiali jaegar

Traces = A Request Full journey Traces

# OpenSource Observability Tools
Metrics = Prometheus[scrape&store|metrics],Grafana[Create|DashBoards|Monitoring|the|system|state]
Logs = Elastic Stack
Traces = Kiali&Jaegar

new relic is where dev,ops,security and business teams solve software performance problems with data

Google SRE book[https://sre.google/sre-book/monitoring-distributed-systems/]

`Monitoring` collect and processing the data about the applications and servers cpompute reosurces,request count,
`BlackBox` Monitoring By clients they were just accessing the app if yes other wise no they did not know why application was not coming
`WhiteBox` Monitoring going to see into internal of the app or system what is why it is bad how became bad we going to analyze
`DashBoard` Good visualization of data
`Alert` send the notification to the respected teams
`RootCauseAnalysis` Once the issue occured you need to figure out exact reason for failure what and why it happen

Why Monitor
- Analyze long term trends
- comparing overtime and experiment groups
- alerting
- Building dashboards it is very difficult know what is the usage of compute resources in the system so we create centralized dashboards to view
- conducting adhoc retrospective analysis[i.e debugging]

Four Golden Singnals

`Latency,Traffic,Errors,Saturation`

Require Singnificant of engineering time

# 3-9-24
you're always look into recent data not  very long data

TSDB based on time  you can get the data based on graph you represent

every point of time you different data

If you maintain v very long data db ops could be slowed

prometheus concentrate more on collecting data,provides alerting mechanism,query language

Prometheus it self is a single point of failure so thanos is a open source highly avialabe prometheus setup with long term storage capabilities

victoria metrics it is simple solution

grafana mimir

for long term data we won't relay on prometheus for recent it is decent to get latest metrics data

Prometheus = data collector
Grafana    = data visualizor 

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

# 9-9-24

elastic search is a searchable DB

Production grade prometheus
Production grade elastic search

- How can i install elastic search and kibana in vm
  - memory intensive instances r7i.large latest gen comes with low cost
- ELK installation

beats - collects the logs
logstash - convert the logs into desirable format
ealsticsearch - searchable db
kibana - visual 

# 10-9-2024

beats[input]   -----> Logstash[output]  -----> Elastic Search ---> Kibana


transactional logs[business logs]
non-transactional logs[system logs]

grok

# 11-9-2024

# 12-9-2024
- create data views for all micro services

# 14-9-2024

# 16-9-2024

# 18-9-24[newrelic]


