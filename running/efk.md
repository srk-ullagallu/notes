We are all are aware big organizations use micor service architecutre means 100s of applications thousands and millions of loggers if you want to analyze all of these logs at one place how can we do it that is concept of observability of your application 

elasti search[logDB]
kibana[visualization]
fluentbit[logcollector]

just in time infrastructure 

What is logging and why does it matter

provides essential insights into system ops aiding troubleshooting security monitoring

logs have [infra+app] related info

each container log is aggregrate to give cohesive view of system behaviour

data processing and analysis

In elastic search data was strored in json format as documents each document is unit of search and driver

Indexing is processing of stroing documents in elastic for quick retrival 

documents
indexing
searching
shards and replicas
mapping in elastic search
crud ops in elastic search


cluster = collection of multiple nodes


A cluster distributes data and ops across the nodes in the cluster providing HA and Scalability

each serve multiple roles

indexing data
respond for search queries

Inverted index is logic behind quick search and how the documents stored in elastic search


DevTools

taint control plane

create ns efk

git clone https://github.com/kodekloudhub/efk-stack.git

