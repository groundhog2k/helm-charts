# CodiMD

[CodiMD](https://github.com/hackmdio/codimd) is a realtime collaborative markdown notes on all platforms.

Look at [CodiMD Documentation](https://hackmd.io/c/codimd-documentation) for detail setting.

## Prerequisites

- Kubernetes 1.14+
- Helm 2.16+ or Helm 3.0+
- PV provisioner support in the underlying infrastructure

## How to use?

```bash
$ helm repo add codimd https://helm.codimd.dev/
$ helm install my-release codimd/codimd
```

## Parameters

### Common Helm parameters

If you use AWS EKS, please setup global.storageClass as `gp2`

| Parameter        | Description                                                                                         | Default |
| ---------------- |:--------------------------------------------------------------------------------------------------- | ------- |
| storageClass     | default storageClass for PersistenVolume                                                            | `nil`   |
| nameOverride     | String to partially override codimd.fullname template with a string (will prepend the release name) | `nil`   |
| fullnameOverride | String to fully override codimd.fullname template with a string                                     | `nil`   |

### Docker image parameters

| Parameter         | Description                      | Default           |
| ----------------- |:-------------------------------- | ----------------- |
| image.registry    | CodiMD docker image registry     | `nabo.codimd.dev` |
| image.repository  | CodiMD docker image repository   | `hackmdio/hackmd`  |
| image.tag         | CodiMD docker image version tag  | `2.2.0`           |
| image.pullPolicy  | CodiMD docker image pull policy  | `IfNotPresent`    |
| image.pullSecrets | CodiMD docker image pull secrets | `[]`              |

### Deploy an internal database parameters

This Helm chart contains `postgreSQL` and `mariaDB`, you just select one database to deploy. if you want to use external database (maybe cloud provider service or self-hosted database), just set `postgresql.enabled` and `mariadb.enabled` to be `false` and manuall assign database connection parameters in `codimd.database`.

| Parameter                          | Description                            | Default    |
| ---------------------------------- |:-------------------------------------- | ---------- |
| postgresql.enabled                 | Deploy a PostgreSQL server as database | `true`     |
| postgresql.volumePermissions       | Enable database persistence using PVC  | `true`     |
| postgresql.postgresqlUsername      | Database user to create                | `codimd`   |
| postgresql.postgresqlPassword      | Password for the database              | `changeme` |
| postgresql.postgresqlDatabase      | Database name to create                | `codimd`   |
| mariadb.enabled                    | Deploy a MariaDB server as database    | `false`    |
| mariadb.volumePermissions.enabled  | Enable database persistence using PVC  | `true`     |
| mariadb.db.user                    | Database user to create                | `codimd`   |
| mariadb.db.password                | Password for the database              | `changeme` |
| mariadb.db.name                    | Database name to create                | `codimd`   |
| mariadb.master.persistence.enabled | Enable database persistence using PVC  | `true`     |
| mariadb.replication.enabled        | MariaDB replication enabled            | `false`    |

### Networking conectivity parameters

If you want use ingress, please set `service.type` to be `ClusterIP`

| Parameter                     | Description                           | Default        |
| ----------------------------- |:------------------------------------- | -------------- |
| service.type                  | Kubernetes Service type               | `LoadBalancer` |
| service.port                  | Service HTTP port                     | `80`           |
| service.externalTrafficPolicy | Service externalTrafficPolicy         | `nil`           |
| service.loadBalancerIP        | Service loadBalancerIP                | `nil`           |
| ingress.enabled               | If `true` Ingress will be created     | `false`        |
| ingress.annotations           | Ingress annotations                   | `nil`          |
| ingress.hosts                 | Ingress hostnames                     | `nil`          |
| ingress.tls                   | Ingress TLS configuration (YAML)      | `nil`          |


### CodiMD common parameters

| Parameter                                      | Description                                                                                               | Default                      |
| ---------------------------------------------- |:--------------------------------------------------------------------------------------------------------- | ---------------------------- |
| codimd.affinity                                | Affinity for pod assignment                                                                               | `nil`                        |
| codimd.tolerations                             | Tolerations for pod assignment                                                                            | `nil`                        |
| codimd.nodeSelector                            | Node labels for pod assignment                                                                            | `nil`                        |
| codimd.podAnnotations                          | Extra annotation for pod                                                                                  | `nil`                        |
| codimd.securityContext.runAsGroup              | Group ID for the CodiMD container                                                                         | `1500`                       |
| codimd.securityContext.runAsUser               | User ID for the CodiMD container                                                                          | `1500`                       |
| codimd.securityContext.fsGroup                 | Group ID for the CodiMD filesystem                                                                        | `1500`                       |
| codimd.securityContext.runAsNonRoot            | Run non root in CodiMD container                                                                          | `trrue`                      |
| codimd.connection.domain                       | The domain name your service will be hosted.                                                              | `nil`                        |
| codimd.connection.urlAddPort                   | Set to assign port for URL. (You don’t need this for ports 80 or 443. This only works when domain is set) | `false`                      |
| codimd.connection.protocolUseSSL               | Use SSL protocol for resources path (applied only when domain is set).                                    | `false`                      |
| codimd.database.type                           | The external database type (only accept `postgres`, `mysql`)                                              | `nil`                        |
| codimd.database.host                           | The host of external database                                                                             | `nil`                        |
| codimd.database.port                           | The port of external database                                                                             | `nil`                        |
| codimd.database.username                       | The username that connects to external database                                                           | `nil`                        |
| codimd.database.password                       | The password that connects to external database                                                           | `nil`                        |
| codimd.database.databaseName                   | The external database name we used                                                                        | `nil`                        |
| codimd.imageUpload.storeType                   | The type of image storage                                                                                 | `filesystem`                 |
| codimd.imageUpload.imgur.clientId              | The Imgur OAuth ClientID                                                                                  | `nil`                        |
| codimd.imageUpload.azure.connectionString      | The Azure image store connection string                                                                   | `nil`                        |
| codimd.imageUpload.azure.container             | The Azure image store container name                                                                      | `nil`                        |
| codimd.imageUpload.lutim.url                   | The lutim URL                                                                                             | `nil`                        |
| codimd.imageUpload.minio.endpoint              | The minio endpoint                                                                                        | `nil`                        |
| codimd.imageUpload.minio.secure                | The minio endpoint is secure or not                                                                       | `nil`                        |
| codimd.imageUpload.minio.port                  | The minio port                                                                                            | `nil`                        |
| codimd.imageUpload.minio.accessKey             | The minio access key                                                                                      | `nil`                        |
| codimd.imageUpload.minio.secretKey             | The minio secret key                                                                                      | `nil`                        |
| codimd.imageUpload.s3.endpoint                 | The AWS s3 endpoint                                                                                       | `nil`                        |
| codimd.imageUpload.s3.region                   | The AWS s3 region                                                                                         | `nil`                        |
| codimd.imageUpload.s3.accessKeyId              | The AWS s3 access key                                                                                     | `nil`                        |
| codimd.imageUpload.s3.secretKey                | The AWS s3 secret key                                                                                     | `nil`                        |
| codimd.imageUpload.s3.bucket                   | The AWS s3 bucket name                                                                                    | `nil`                        |
| codimd.imageStorePersistentVolume.enabled      | Enable image persistence using PVC                                                                        | `true`                       |
| codimd.imageStorePersistentVolume.size         | The size of persistence volume                                                                            | `10Gi`                       |
| codimd.imageStorePersistentVolume.storageClass | The storageClass of persistence volume                                                                    | `-`                          |
| codimd.imageStorePersistentVolume.accessModes  | The accessModes of persistence volume                                                                     | [`ReadWriteOnce`]            |
| codimd.imageStorePersistentVolume.volumeMode   | The volumeMode of persistence volume                                                                      | `Filesystem`                 |
| codimd.versionCheck                            | Enable automatically version checker                                                                      | `true`                       |
| codimd.security.useCDN                         | Whether CodiMD would use static assets served on CDN                                                      | `false`                      |
| codimd.security.sessionSecret                  | The secret string to sign session, please must change this value                                          | `changeit`                   |
| codimd.security.sessionLife                    | The time to expire for session                                                                            | `1209600000`                 |
| codimd.security.hstsEnabled                    | Whether HTST is enabled or not                                                                            | `true`                       |
| codimd.security.hstsMaxAge                     |                                                                                                           | `31536000`                   |
| codimd.security.hstsIncludeSubdomain           |                                                                                                           | `false`                      |
| codimd.security.hstsPreload                    |                                                                                                           | `true`                       |
| codimd.security.cspEnabled                     | Whether CSP is enabled or not                                                                             | `true`                       |
| codimd.security.cspReportUri                   |                                                                                                           | `nil`                        |
| codimd.security.allowOrigin                    |                                                                                                           | `nil`                        |
| codimd.security.allowGravatar                  |                                                                                                           | `true`                       |
| codimd.allowPDFExport                          |                                                                                                           | `false`                      |
| codimd.responseMaxLag                          |                                                                                                           | `70`                         |
| codimd.noteCreation.freeUrlEnabled             | Allow using free url to create note                                                                       | `false`                      |
| codimd.noteCreation.freeUrlForbiddenNoteIds    |                                                                                                           | `robots.txt,favicon.ico,api` |
| codimd.noteCreation.defaultPermission          | The default permission for note created                                                                   | `editable`                   |
| codimd.notePermission.allowAnonymousEdit       | Enable anonymouse edit                                                                                    | `true`                       |
| codimd.notePermission.allowAnonymousView       | Enable anonymouse view                                                                                    | `true`                       |
| codimd.markdown.plantUMLServer                 |                                                                                                           | `nil`                        |
| codimd.markdown.useHardBreak                   |                                                                                                           | `true`                       |
| codimd.markdown.linkifyHeaderStyle             |                                                                                                           | `keep-case`                  |
| codimd.extraEnvironmentVariables               | Extra environment variable for CodiMD container                                                           | `{}`                         |
### CodiMD Authentication Method parameters

| Parameter                                               | Description                                                                                               | Default           |
| ------------------------------------------------------- |:--------------------------------------------------------------------------------------------------------- | ----------------- |
| codimd.authentication.local.enabled                     | Enable to use email for auth                                                                              | `true`            |
| codimd.authentication.local.allowRegister               | Allow register with email                                                                                 | `true`            |
| codimd.authentication.bitbucket.enabled                 | Enable to use BitBucket for auth                                                                          | `false`           |
| codimd.authentication.bitbucket.key                     | OAuth key for BitBucket auth                                                                              | `nil`             |
| codimd.authentication.bitbucket.secret                  | OAuth secret for BitBucket auth                                                                           | `nil`             |
| codimd.authentication.dropbox.enabled                   | Enable to use Dropbox for auth                                                                            | `false`           |
| codimd.authentication.dropbox.appKey                    | OAuth app key for Dropbox auth                                                                            | `nil`             |
| codimd.authentication.dropbox.appSecret                 | OAuth app secret for Dropbox auth                                                                         | `nil`             |
| codimd.authentication.facebook.enabled                  | Enable to use Facebook for auth                                                                           | `false`           |
| codimd.authentication.facebook.clientId                 | OAuth client id for Facebook auth                                                                         | `nil`             |
| codimd.authentication.facebook.secret                   | OAuth secret for Facebook auth                                                                            | `nil`             |
| codimd.authentication.github.enabled                    | Enable to use GitHub for auth                                                                             | `false`           |
| codimd.authentication.github.clientId                   | OAuth client id for GitHub auth                                                                           | `nil`             |
| codimd.authentication.github.secret                     | OAuth secret for GitHub auth                                                                              | `nil`             |
| codimd.authentication.github.enterpriseUrl              | GitHub Enterprise OAuth endpoint url for GitHub auth                                                      | `nil`             |
| codimd.authentication.gitlab.enabled                    | Enable to use GitLab for auth                                                                             | `false`           |
| codimd.authentication.gitlab.domain                     | GitLab instance domain for GitLab auth                                                                    | `nil`             |
| codimd.authentication.gitlab.scope                      | OAuth scope for GitLab auth                                                                               | `nil`             |
| codimd.authentication.gitlab.applicationId              | OAuth application id for GitLab auth                                                                      | `nil`             |
| codimd.authentication.gitlab.secret                     | OAuth secret for GitLab auth                                                                              | `nil`             |
| codimd.authentication.google.enabled                    | Enable to use Google for auth                                                                             | `false`           |
| codimd.authentication.google.clientId                   | OAuth client id for Google auth                                                                           | `nil`             |
| codimd.authentication.google.secret                     | OAuth secret for Google auth                                                                              | `nil`             |
| codimd.authentication.google.hostedDomain               | Google hosted OAuth domain for Google auth                                                                | `nil`             |
| codimd.authentication.ldap.enabled                      | Enable to use LDAP for auth                                                                               | `false`           |
| codimd.authentication.ldap.providerName                 | See the LDAP doc                                                                                          | `nil`             |
| codimd.authentication.ldap.url                          |                                                                                                           | `nil`             |
| codimd.authentication.ldap.tlsCA                        |                                                                                                           | `nil`             |
| codimd.authentication.ldap.bindDN                       |                                                                                                           | `nil`             |
| codimd.authentication.ldap.bindCredentials              |                                                                                                           | `nil`             |
| codimd.authentication.ldap.searchBase                   |                                                                                                           | `nil`             |
| codimd.authentication.ldap.searchFilter                 |                                                                                                           | `nil`             |
| codimd.authentication.ldap.searchAttributes             |                                                                                                           | `nil`             |
| codimd.authentication.ldap.attributes.id                |                                                                                                           | `nil`             |
| codimd.authentication.ldap.attributes.username          |                                                                                                           | `nil`             |
| codimd.authentication.mattermost.enabled                | Enable to use Mattermost for auth                                                                         | `false`           |
| codimd.authentication.mattermost.domain                 | OAuth doamin for Mattermost auth                                                                          | `nil`             |
| codimd.authentication.mattermost.clientId               | OAuth client id for Mattermost auth                                                                       | `nil`             |
| codimd.authentication.mattermost.secret                 | OAuth secret for Mattermost auth                                                                          | `nil`             |
| codimd.authentication.oauth2.enabled                    | See the OAuth2 doc                                                                                        | `false`           |
| codimd.authentication.oauth2.providerName               |                                                                                                           | `nil`             |
| codimd.authentication.oauth2.domain                     |                                                                                                           | `nil`             |
| codimd.authentication.oauth2.clientId                   |                                                                                                           | `nil`             |
| codimd.authentication.oauth2.secret                     |                                                                                                           | `nil`             |
| codimd.authentication.oauth2.authorizationUrl           |                                                                                                           | `nil`             |
| codimd.authentication.oauth2.tokenUrl                   |                                                                                                           | `nil`             |
| codimd.authentication.oauth2.userProfileUrl             |                                                                                                           | `nil`             |
| codimd.authentication.oauth2.scope                      |                                                                                                           | `nil`             |
| codimd.authentication.oauth2.attributes.username        |                                                                                                           | `nil`             |
| codimd.authentication.oauth2.attributes.displayName     |                                                                                                           | `nil`             |
| codimd.authentication.oauth2.attributes.email           |                                                                                                           | `nil`             |
| codimd.authentication.openID.enabled                    | See the OpenID doc                                                                                        | `false`           |
| codimd.authentication.saml.enabled                      | See the SAML doc                                                                                          | `false`           |
| codimd.authentication.saml.idpSSOUrl                    |                                                                                                           | `nil`             |
| codimd.authentication.saml.idpCert                      |                                                                                                           | `nil`             |
| codimd.authentication.saml.issuer                       |                                                                                                           | `nil`             |
| codimd.authentication.saml.identifierFormat             |                                                                                                           | `nil`             |
| codimd.authentication.saml.disableRequestedAuthnContext |                                                                                                           | `nil`             |
| codimd.authentication.saml.groupAttribute               |                                                                                                           | `nil`             |
| codimd.authentication.saml.externalGroups               |                                                                                                           | `nil`             |
| codimd.authentication.saml.requiredGroups               |                                                                                                           | `nil`             |
| codimd.authentication.saml.attributes.id                |                                                                                                           | `nil`             |
| codimd.authentication.saml.attributes.username          |                                                                                                           | `nil`             |
| codimd.authentication.saml.attributes.email             |                                                                                                           | `nil`             |
| codimd.authentication.twitter.enabled                   | Enable to use Twitter for auth                                                                            | `false`           |
| codimd.authentication.twitter.consumerKey               | OAuth consumer key for Twitter auth                                                                       | `nil`             |
| codimd.authentication.twitter.comsumerSecret            | OAuth consumer secret for Twitter auth                                                                    | `nil`             |
