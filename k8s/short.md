# Services

`clusterIP`

`NodePort`

`LoadBalancer`

`ExternalName` service same as the clusterIP service with the exception of instead returning `staticIP` it return `CNAME` record 

spa-db.bapatlas.site ---> ExternalNameService ---> PODs

