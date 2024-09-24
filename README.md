# Action hcloud cli
This Action is used to create a server on hetzner cloud with hcloud cli
## Caution
The server is created with the last backup of Project is recommended to create a backup before running the action

## Note
if the repository has a file called cloud-config.yml it will be used to create the server but is required actions/checkout@v4 in this case

## Inputs
see [action.yml](action.yml)
### Example usage
```yaml
jobs:
  create_staging:
    runs-on: ubuntu-latest
    steps:
      - name: checkout
        uses: actions/checkout@v4
      - name: create staging
        uses: OctupusTechnologies/hetzner-action@main
        id: create_staging_server
        with:
          NAME_SERVER: 'staging'
          TYPE_SERVER: 'cpx31'
          HETZNER_PROJECT_TOKEN: ${{ secrets.HETZNER_PROJECT_TOKEN }}
          HETZNER_SSH_KEY_NAME: 'staging,root'
          HETZNER_DNS_ZONE: ${{ secrets.HETZNER_DNS_ZONE }}
          HETZNER_FIREWALL_NAME: 'Web,firewall-xdebug'
          HETZNER_DNS_TOKEN: ${{ secrets.HETZNER_DNS_TOKEN }}
          HETZNER_CLOUD_COIFIG: 'cloud-config.yml'

```

