# Learning With Texts for Kubernetes

This repo contains a Dockerfile and a Helm chart for deploying the [Learning With Texts](http://lwt.sourceforge.net/) language learning app.

## Deploying Learning With Texts on Minikube

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

## Deploying Learning With Texts

First, download the dependencies.

```
helm dep update lwt-chart/
```

Next, create a persistent volume however you see fit to bind with the persistent volume claim labelled `app: lwt-mysql`.

Finally, install the chart replacing values where appropriate.

```
helm install lwt-chart/ \
    --set mysql.mysqlDatabase=[my-database] \
    --set mysql.mysqlUser=[my-db-user] \
    --set mysql.mysqlPassword=[my-db-password] \
    --set ingress.enabled=true \
    --set ingress.basicAuth.enabled=true \
    --set ingress.basicAuth.auth=`htpasswd -n -b [my-username] [my-password]` \
    --set ingress.paths[0]=/ \
    --name lwt
```
