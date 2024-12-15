# 3-tier Single Page Application

# General Flow
spa.bapatlas.site[CF]  -->  S3 --> ALB --> ECS --> RDS

# RDS
- Create RDS
- Load the Schema
- Create SG for RDS name as spa-rds
- allow 3306 traffic from only spa-ecs
- create CNAME record for RDS ENdpoint

# ECS
- create SG for `spa-ecs` allow 8080 from only `spa-alb`
- create SG for `spa-alb` allow 80 and 443 from anywhere or allow only from cloud front ip rages
- create namespace as `spa-crud`
- create service[cloudmap] as `spa-backend`
- create loggroup for backend
- create task definition for backend
- create ecs service for run containers in the ECS cluster
- The Container Allowed origin is only from CF endpoint or `CF CNAME` for example `https://<cloud-front-record>`
- Create Target Group,ALB and Listners both 80 and 443 and change the default rule redirect to https
- update the service to add targets to target group

# S3
- create a bucket
- upload the index.html into bucket
- edit the bucket policy allow only from cloudfront
- enable cors 
```json
[
    {
        "AllowedHeaders": [
            "*"
        ],
        "AllowedMethods": [
            "GET",
            "POST",
            "PUT",
            "DELETE"
        ],
        "AllowedOrigins": [
            "https://spa.bapatlas.site"
        ],
        "ExposeHeaders": [],
        "MaxAgeSeconds": 3000
    }
]
```
- In your index.html you can pass alb endpoint as for example `https://spa-backend.bapatlas.site/api/entries`
