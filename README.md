# Learning With Texts for Kubernetes

This repo contains a Dockerfile and a Helm chart for deploying the [Learning With Texts](http://lwt.sourceforge.net/) language learning app.

## Deploying Learning With Texts

First, download the dependencies.

```
helm dep update lwt-chart/
```

Next, install the chart replacing values where appropriate.

```
helm install lwt-chart/ \
    --set mysql.mysqlDatabase=[my-database-name] \
    --set mysql.mysqlUser=[my-database-username] \
    --set mysql.mysqlPassword=[my-database-password] \
    --set service.type=NodePort \
    --name lwt
```
