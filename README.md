# Action hcloud cli
Uses the hcloud cli to create a server and rebuild

## Inputs
see [action.yml](action.yml)
### Example usage
```yaml
name: 'Staging server create'
on:
  pull_request:
    types:
      - opened

  workflow_dispatch:

jobs:
  create_staging:
    runs-on: ubuntu-latest
    steps:
      - name: create staging
        uses: OctupusTechnologies/hetzner-action@1.0
        id: create_staging_server
        with:
          NAME_SERVER: staging
          TYPE_SERVER: cx31
          HETZNER_PROJECT_TOKEN: ${{ secrets.HETZNER_PROJECT_TOKEN }}
          HETZNER_SSH_KEY_NAME: SSH_NAME
          HETZNER_DNS_ZONE: ${{ secrets.HETZNER_DNS_ZONE }}
          HETZNER_FIREWALL_NAME: Web
          HETZNER_DNS_TOKEN: ${{ secrets.HETZNER_DNS_TOKEN }}
      - name: set output
        run: echo "The server IP is ${{ steps.create_staging_server.outputs.SERVER_IPV4 }}"
```

