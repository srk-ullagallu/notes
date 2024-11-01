# 2-9-24

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



