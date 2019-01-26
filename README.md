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

Next, create a persistent volume however you see fit to bind with the persistent volume names `lwt-mysql`.

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

## Configuration

| Parameter                 | Description                                                                       | Default                                     |
|---------------------------|-----------------------------------------------------------------------------------|---------------------------------------------|
| image                     | learning-with-texts image repository                                              | proubatsis/learning-with-texts              |
| imageTag                  | learning-with-texts image tag                                                     | latest                                      |
| mysql.mysqlDatabase       | Name of database to create                                                        |                                             |
| mysql.mysqlPassword       | Password to access database                                                       |                                             |
| mysql.mysqlUser           | Username to access database                                                       |                                             |
| ingress.enabled           | Enable ingress                                                                    | false                                       |
| ingress.basicAuth.enabled | Enable basic auth                                                                 | false                                       |
| ingress.basicAuth.auth    | Basic auth htpasswd, generate value using `htpasswd -n -b [username] [password]`. | admin:$apr1$Bsungw4w$d1B3tEUHG2J47rVjG9Yij0 |
| ingress.paths[*]          | Path that ingress should route requests for                                       |                                             |
| ingress.hosts[*]          | Host that ingress should listen for requests on                                   | ["chart-example.local"]                     |
| ingress.tls[*].secretName | Secret name for TLS certificate                                                   |                                             |
| ingress.tls[*].hosts[*]   | Hosts that should have TLS enabled                                                |                                             |
| ingress.clusterIssuer     | If TLS is enabled then this is used to automatically issue certificates           | default-issuer                              |
