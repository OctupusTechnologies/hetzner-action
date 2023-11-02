# Action hcloud cli
Uses the hcloud cli to create a server and rebuild

## Inputs
see [action.yml](action.yml)
### Example usage
```yaml
uses: actions/hcloud-cli@v1
with:
  token: ${{ secrets.HCLOUD_TOKEN }}
  server-name: my-server
  server-type: cx11
  image: bac
  ssh-key: ${{ secrets.SSH_KEY }}
  ssh-key-name: my-ssh-key
  user-data: |
    #cloud-config
    users:
      - name: my-user
        ssh-authorized-keys:
          - ${{ secrets.SSH_KEY }}
        sudo: ['ALL=(ALL) NOPASSWD:ALL']
        groups: sudo
        shell: /bin/bash
        lock_passwd: false
        plain_text_passwd: my-password
```
