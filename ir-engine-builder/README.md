# Infinite Reality Engine

[Infinite Reality Engine](https://www.theinfinitereality.com/ir-engine/) Social Gatherings on the Web.

## TL;DR

```console
helm repo add ir-engine https://helm.ir-engine.io
helm install my-release ir-engine/ir-engine
```

## Introduction

This chart creates a [Infinite Reality Engine](https://www.theinfinitereality.com/ir-engine/) deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

[***In Progress***] This chart has been tested to work with NGINX Ingress, cert-manager, fluentd and Prometheus on top of AWS EKS.


## Prerequisites

- Kubernetes 1.14+
- Helm v2.11+ or Helm 3.1+ to run "weighted" hooks in right order.
- Persistent Volumes provisioner support in the underlying infrastructure.

## Installing the Chart

To install the chart with the release name `my-release`:

``` bash
helm repo add ir-engine https://helm.ir-engine.io
helm repo update
helm install my-release ir-engine/ir-engine            # Helm 3
helm install --name my-release ir-engine/ir-engine     # Helm 2
```

Infinite Reality Engine
The command deploys Infinite Reality Engine on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following table lists the configurable parameters of the Infinite Reality Engine chart and their default values.

| Key                              | Type | Default | Description                |
|----------------------------------|------|---------|----------------------------|
| agones.enabled                   | bool | `false` | Install Agones included with chart, set `false` if you have it installed already on your cluster |
| client.affinity                  | object | `{}` | Node affinity for the client service |
| client.enabled                   | bool | `true` | Install xrsocial-client service |
| **client.extraEnv**              | object | `{}` | [Additional Configuration](#ir-engine-additional-configurations) for the client service |
| client.image.pullPolicy          | string | `"Always"` | Image pull policy |
| client.image.repository          | string | `"xrsocial/client"` | repo to pull client image from |
| client.image.tag                 | string | `"latest"` | client version to pull |
| client.imagePullSecrets          | list | `[]` | if using a private repo, specify a pull secret |
| client.ingress.annotations       | object | `{"kubernetes.io/ingress.class": "nginx"}` | if using a different ingress controller, specify it |
| client.ingress.enabled           | bool | `true` | disable ingress definitions |
| **client.ingress.hosts[0].host** | string | `"my.ir-engine.com"` | hostname for the client |
| client.ingress.hosts[0].paths[0] | string | `"/"` | default path for client |
| client.name                      | string | `"xrsocial-client"` | client service name |
| client.nameOverride              | string | `""` | changes the client service name |
| client.nodeSelector              | object | `{}` | selects a specific node to run on |
| client.securityContext           | object | `{}` | overrides client security context |
| client.service.port              | int | `3000` | default client port |
| client.service.type              | string | `"ClusterIP"` | override client service type |
| client.serviceAccount            | object | `{}` | override client service account |
| client.tolerations               | list | `[]` |  |
| domain                           | string | `"ir-engine.dev"` | domain root for all services, services will be subdomain from it |
| server.affinity                  | object | `{}` |  |
| server.enabled                   | bool | `true` | Install the xrsocial service |
| **server.extraEnv**              | object | `{}` | [Additional Configuration](#ir-engine-additional-configurations) for xrsocial service |
| server.fullnameOverride          | string | `""` | override server fullname template |
| server.image.pullPolicy          | string | `"Always"` | Server pull policy |
| server.image.repository          | string | `"ir-engine/xrsocial"` | server image repo |
| server.image.tag                 | string | `"latest"` | server image version |
| server.imagePullSecrets          | list | `[]` | server image pull secret |
| server.ingress.annotations       | object | `{"kubernetes.io/ingress.class": "nginx"}` | server ingress class |
| server.ingress.enabled           | bool | `true` | enable ingress traffic to server |
| **server.ingress.hosts[0].host** | string | `"api.xrsocial.com"` | hastname for server service, used by client for API and backend operations |
| server.ingress.hosts[0].paths[0] | string | `"/"` | default path for server over http |
| server.name                      | string | `"xrsocial"` | server service name |
| server.nameOverride              | string | `""` | overrides name template |
| server.nodeSelector              | object | `{}` | specify a node selector |
| server.podSecurityContext        | object | `{}` | server pod security |
| server.replicaCount              | int | `1` | How many server instances to run |
| server.resources                 | object | `{}` | CPU/Memory resource requests/limits |
| server.securityContext           | object | `{}` | overrides server security context |
| server.service.port              | int | `3030` | service http port |
| server.service.type              | string | `"ClusterIP"` | Kubernetes service type |
| sql.database                     | string | `"ir-engine"`                               | Database name within SQL server to connect to                                                    |
| sql.password                     | string | `"password"`                               | Password for the SQL user.                                                                       |
| sql.user                         | string | `"ir-engine"`                               | Username to connect to SQL database                                                              |
| sql.host                         | string | `nil`                                      | hostname of SQL server                                                                           |
| sql.port                         | int | `3306`                                     | host port of SQL server                                                                          |

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```console
$ helm install --name my-release \
  --set persistence.enabled=false,email.host=email \
    ir-engine/ir-engine
```

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart. For example,

```console
helm install --name my-release -f values.yaml ir-engine/ir-engine
```

> **Tip**: You can use the default <values.yaml>

## Infinite Reality Engine Additional Configurations

This section lists configuration specific for server, client components.

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| client.extraEnv.NODE_ENV | string | `"development"` |  |
| client.extraEnv.SITE_DESC | string | `"Connected Worlds for Everyone"` |  |
| client.extraEnv.SITE_TITLE | string | `"Infinite Reality Engine"` |  |
| rts.extraEnv.NAF_LISTEN_PORT | string | `"8081"` |  |
| server.extraEnv.APP_HOST | string | `"http://api.ir-engine.local/"` |  |
| server.extraEnv.FACEBOOK_CALLBACK_URL | string | `"http://127.0.0.1:3000/oauth/facebook"` |  |
| server.extraEnv.FACEBOOK_CLIENT_ID | string | `nil` |  |
| server.extraEnv.FACEBOOK_CLIENT_SECRET | string | `nil` |  |
| server.extraEnv.GITHUB_CALLBACK_URL | string | `"http://127.0.0.1:3000/oauth/github"` |  |
| server.extraEnv.GITHUB_CLIENT_ID | string | `nil` |  |
| server.extraEnv.GITHUB_CLIENT_SECRET | string | `nil` |  |
| server.extraEnv.GOOGLE_CALLBACK_URL | string | `"http://127.0.0.1:3000/oauth/google"` |  |
| server.extraEnv.GOOGLE_CLIENT_ID | string | `nil` |  |
| server.extraEnv.GOOGLE_CLIENT_SECRET | string | `nil` |  |
| server.extraEnv.MAIL_FROM | string | `"noreply@ir-engine.local"` |  |
| server.extraEnv.MYSQL_DATABASE | string | `"ir-engine"` |  |
| server.extraEnv.MYSQL_PASSWORD | string | `"password"` |  |
| server.extraEnv.MYSQL_PORT | int | `3306` |  |
| server.extraEnv.MYSQL_USER | string | `"server"` |  |
| server.extraEnv.PORT | string | `"3030"` |  |
| server.extraEnv.SMTP_HOST | string | `nil` |  |
| server.extraEnv.SMTP_PASS | string | `nil` |  |
| server.extraEnv.SMTP_PORT | string | `nil` |  |
| server.extraEnv.SMTP_USER | string | `nil` |  |
| server.extraEnv.STORAGE_AWS_ACCESS_KEY_ID | string | `"<AWS ACCESS KEYS>"` |  |
| server.extraEnv.STORAGE_AWS_ACCESS_KEY_SECRET | string | `"<AWS SECRET>"` |  |
| server.extraEnv.STORAGE_PROVIDER | string | `"local"` |  |
| server.extraEnv.STORAGE_S3_BUCKET_NAME | string | `"ir-engine-storage"` |  |
| server.extraEnv.STORAGE_S3_CLOUDFRONT_DOMAIN | string | `"https://<MyCdnDistribution>.s3.amazonaws.com"` |  |
| server.extraEnv.STORAGE_S3_PUBLIC_VIDEO_BUCKET | string | `"ir-engine-video"` |  |
| server.extraEnv.STORAGE_S3_PUBLIC_VIDEO_PATH | string | `"/"` |  |
| server.extraEnv.STORAGE_S3_REGION | string | `"<S3 Region>"` |  |

## Ingress

This chart provides support for Ingress resource. If you have an available Ingress Controller such as Nginx or Traefik you maybe want to set `ingress.enabled` to true and choose an `server.ingress.hosts[0].host` and `client.ingress.hosts[0].host` for the URL. Then, you should be able to access the installation using that address.

## Metrics and Performance monitoring

[*TBD*]

## Error reporting and Alerts

[*TBD*]

## Upgrading

[*TBD* - This section will describe any information needed when upgrading the Platform or the chart itself]