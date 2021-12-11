# GCloud Pantheon Backups

Run backups of a list of Pantheon sites. Useful for automating backups for sites that aren't on paid plans yet.

## Run the app on Google Cloud Run

- [Build and deploy a Shell service](https://cloud.google.com/run/docs/quickstarts/build-and-deploy/shell)
- [Setting request timeout](https://cloud.google.com/run/docs/configuring/request-timeout#command-line)
    - Backups can be slow; if you have multiple sites, you'll probably need this higher than the default value of 5min.
- [Environment variables](https://cloud.google.com/run/docs/configuring/environment-variables)
    - This script requires `$TERMINUS_TOKEN` (a Terminus machine token) and `$SITES` (a comma-separated list of site names).
- [Running services on a schedule](https://cloud.google.com/run/docs/triggering/using-scheduler)