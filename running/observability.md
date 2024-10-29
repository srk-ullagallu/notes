If you have observability setup you can get insternal state of the system[Application,Infra structure,Network]

Understanding state of the system is working as expected or there any failures in networking latency

[Metrics|help|us|to|know|about|what|is|the|state|of|the|system]
- Last 24 hours what is the memory,disk,cpu utilization of a node in a cluster[under,over,partially[utilized],at particular time utilization is at peak] though out the day cpu utilization is very normal At one point utilization goes peak after some time back to normal this where if you know the hisotrical data you can get to know what is the issue 
- Out of 10000 http requests how many requests are successed,failed

[Logs|are|help|us|to|know|about|to|get|the|reason|why|my|system|in|particular|state]
- Why my http requests are failed what is the reason for it 
- In which part of the app request is failed you can get the complete info of the failure
- Why memory leak which cause extra memeory usage particualr app 

[Traces|are|help|us|to|track|where|my|http|request|went|unreachable]
- It gives end to end http request flow right from client to DB
- Using Traces to track which part of the application memory leak


A API[http|request] call to application failed 

- over the last 30 mins 10 http requests are failed [we can get the this hsitroical data using metrics]

- Using the hisotrincal data take the one http request using time stamp at 10.o clock this http request got failed you can go the logs of the app what happend 10o clock who send the application which part of the app request got failed what could be the reason for http request got failed 

- Traces gives the complete http request history right from the client to DB
  Client--->LB--->Frontend---->Backend---->DB
  - You can get is http request reached to client to LB okay how time it will take to reach LB from Client What is the latency
  is it expected or not is got to expected backend  as you configured   
            
            
`Metrics` is a Collecting historical data of the event[cpu,memroy,disk,httprequest,n/w[i/o]] last 30 mins what is the state of the system[cpu,memroy,disk,httprequest,n/w[i/o]]

`Logs` using logs to get to know why my application got failed is it connection[warning,info,debug,error,tracing]

`Observability` is a `metrics` `logging` `logging`

`Monitoring` is `metrics` `alerts` `dashboards`

`Monitoring` is a sub part of `observability`

`Observability` is a whole thing you can get feedback of your system

`SLA` agreement b/w organization and customer made promises to the customer 99.9% platfotm will be avialable through the year app goes down chances[0.1%]
- out of 10000 requests sent to our application 99995 request respond back[~30ms] response back with success code 

We signed multiple SLA with Different customers 

By making Strong objectives how do we meeting the your expectations 

You need a system to get continously feedback about if 1,2,3 requests got failed you immediately take action 

A strong observability platform is required so that you can get complete info about is the state meeting SLA's,why are they failing and how to immediately address it

Observability is a collective effect [Developers,Devops]

Devlopers first they instrument the app it omit the logs,traces
If they did not instrument in your app there is no way that DevOps did not do nothing if the developer should not instrument nothing will get even though you have prometheus,ELK,jaegar


`Metric` is nothing but periodical data or hisotrical data of the events to understand about the health of the system

using metrics we can understand system is good condition or not good condition one problem with metrics is complete raw info 
which is not easy to read this to much numerical info you can also miss some things what is the right way to read the metrics so we can seed the metrics to a monitoring system shows us in a graphical format so it is easy to anyone to read

A monitoring system collects or scrape the metrics which is represents in metrics dashboard it can be any kind of dashboard is there any spike you can clearly see the spike

In montoring system you can also setup `alert` if the cpu utlization goes above 80% send an alert to slack,email[medium]

a monitoring system is basically getting the information from the metrics scraping or pulling the metrics info  and representing that information in a well readable format using the dashboards and it is also capable of firing the alerts when something is wrong

abnormality

- cpu utilization
- memory
- disk
- N/W
- Pod status
- Pod restarts
- Deployments
- HPA
- Replicas of Deployments
- http requests received by app
- users signed up

- To understand health and status of the system

- It can be `push` or `pull` mechanism we will use common word call as `scraping` which can be understand as `pull`

- Somebody push the metrics to the monitoring system or it will `scrape` metrics and it will represent info in visual format or graph

- create some alert rules

- Monitoring is a superset it has `metrics` `dashboards` and `alerts`

`Prometehus Architecture`

- Retrieval
- TSDB
- AlertManager
- HTTP Server


PromQL

`Grafana` provides strong visualization you can see very rich dashboards they bring very strong monitoring stack

`NodeExporter` to get infrastructure level metrics
`Kube-state-metrics` to get k8s cluster metrics
`/metrics` to get app level metrics

In fact `Prometheous` is a `CNCF` project is has very strong community

curl ip:8080/metrics | grep container | grep restart

kubectl run busybox-crash --image=busybox  -- /bin/sh -c "exit 1"

How many times pods are crashed
How many config maps are created

Prometehus has basic user interface 

What is the reason for grafana

It gives better visualization having rich set of dashboards

Grafana supports multiple data sources not only prometehus

Grafana also have auth&authorization also can able to integrate IAM,SSO

Grafana comes with some predefined graphs


Prometheus has 

- Gauges[metric|increamented|decremented][if the nature of metric is always fluctuated +/-]
- Counter[metric|is|incremented|only][If the nature of metrics is always +]
- Summary
- Histogram[You don't worry about +/- just need bucket of info]

http request duration

When a developer instrumenting the metrics when they implementing metrics then can define metrics type like above 4 types

service monitor 





 



 





