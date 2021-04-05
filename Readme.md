# [jpf91/samba-server](https://github.com/jpf91/docker-samba-server)

This image provides a Samba server image based on the latest fedora release.

## Supported Architectures

Currently only `x86_64` images are being built, allthough the `Dockerfile` is not architecture dependent.

## Usage

Here are some instructions and snippets to help you get started creating a container.

### Samba configuration

Before starting the container the first time, you need to setup a samba configuration file:

Here's an example:
```
[global]
    workgroup = WORKGROUP
    security = user
    map to guest = bad user
    guest account = nobody

[Musik]
    path = /mnt/storage/Musik
    guest ok = yes
    writeable = yes
    create mask = 0664
    directory mask = 0775
    force user = nobody
    force group = users
```

For more information, refer to the man page for `/etc/samba/smb.conf`.


### Running using podman cli

```
podman run --name samba-server \
  -h nas.example.com \
  --net host \
  -e container=podman \
  -v /mnt/storage:/mnt/storage \
  -v </path/to/appdata/smb.conf>:/etc/samba/smb.conf \
  -v </path/to/ipa-client-data/data/krb5.keytab>:/etc/krb5.keytab \
  -v </path/to/ipa-client-data/data/krb5.conf>:/etc/krb5.conf \
  -v </path/to/ipa-client-data/data/krb5.conf.d>:/etc/krb5.conf.d \
  -v </path/to/ipa-client-data/data/pipes>:/var/lib/sss/pipes \
  docker.io/jpf91/samba-server
```

## Parameters

Container images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 22:22` would expose port `22` from inside the container to be accessible from the host's IP on port `22` outside the container.

| Parameter | Function |
| :----: | --- |
| `--net host` | Using host networking easily enables all tcp/udp ports. You can use normal networking and specify the NFS ports as well. |
| `-h nas.example.com` | Set the hostname, must be fully qualified. |
| `-v /etc/samba/smb.conf` | Samba configuration. See above for an example. |
| `-v /etc/krb5.keytab` | The SSSD container will write kerberos information to this file. |
| `-v /etc/krb5.conf` | For SSSD integration, share this with your SSSD container. |
| `-v /etc/krb5.conf.d` | For SSSD integration, share this with your SSSD container. |
| `-v /var/lib/sss/pipes/` | For SSSD integration, share this with your SSSD container. |

## Support Info

* Shell access whilst the container is running: `podman exec -it samba-fileserver /bin/bash`
* To monitor the logs of the container in realtime: `podman logs -f samba-fileserver`
* Report bugs [here](https://github.com/jpf91/docker-samba-server).

## Building locally

If you want to make local modifications to these images for development purposes or just to customize the logic:
```
git clone https://github.com/jpf91/docker-samba-server.git
cd docker-samba-server
podman build \
  -t docker.io/jpf91/samba-server:latest .
```

## Versions

* **05.04.21:** - Use fedora-systemd base image.
* **03.04.21:** - Initial Release.
