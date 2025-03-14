# 🎽 Cloud Run Github runner

## Getting started

### Deploy to Cloud Run worker pool

Clone:

```sh
git clone https://github.com/JulienBreux/cloud-run-github-runner/
```

Create the secret:

> [!IMPORTANT]
> Change the values of `GITHUB_SECRET_VALUE`.
> See [How to get a Github register token]

```sh
gcloud secrets create GH_TOKEN --replication-policy="automatic"
echo -n "GITHUB_SECRET_VALUE" | gcloud secrets versions add GH_TOKEN --data-file=-
```

Permissions:

> [!NOTE]
> Need to set the `secretAccessor` to the right service account.

```sh
gcloud secrets add-iam-policy-binding GH_TOKEN \
--member="serviceAccount:XXXX@developer.gserviceaccount.com" \
--role="roles/secretmanager.secretAccessor"
```

Deploy:

> [!IMPORTANT]
> Change the values of `GITHUB_USER_OR_ORGANIZATION` and `REPOSITORY_NAME`.

```sh
gcloud alpha run worker-pools deploy cloud-run-github-runner \
--source=. \
--min=1 \
--set-env-vars GH_OWNER=GITHUB_USER_OR_ORGANIZATION,GH_REPOSITORY=REPOSITORY_NAME \
--set-secrets GH_TOKEN=GH_TOKEN:latest
```

> [!NOTE]
> In this case `cloud-run-github-runner` is the name of the Cloud Run Worker pool.

### Deploy to Docker

Clone:

```sh
git clone https://github.com/JulienBreux/cloud-run-github-runner/
```

Build:

```sh
cd cloud-run-github-runner/
docker build \
--build-arg TARGETOS=linux \
--build-arg TARGETARCH=amd64 \
--build-arg RUNNER_VERSION=2.292.0 \
--tag cloud-run-github-runner .
```

Deploy:

> [!IMPORTANT]
> Change the values of `GITHUB_TOKEN`, `GITHUB_USER_OR_ORGANIZATION` and `REPOSITORY_NAME`.

```sh
docker run \
-e GH_TOKEN=GITHUB_TOKEN \
-e GH_OWNER=GITHUB_USER_OR_ORGANIZATION \
-e GH_REPOSITORY=REPOSITORY_NAME \
-d cloud-run-github-runner
```

> [!NOTE]
> In this case `cloud-run-github-runner` is the name of the Cloud Run Worker pool.

## Security

See [CONTRIBUTING](CONTRIBUTING.md#security-issue-notifications) for more information.

## License

[Apache 2.0](LICENSE)
