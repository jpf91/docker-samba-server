# https://fedoramagazine.org/building-smaller-container-images/
FROM docker.io/jpf91/fedora-systemd

# https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/using_containerized_identity_management_services/configuring-the-sssd-container-to-provide-identity-and-authentication-services-on-atomic-host
# https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/using_containerized_identity_management_services/deploying-sssd-containers-with-different-configurations
RUN microdnf install \
    sssd-client iputils krb5-workstation samba && \
    microdnf clean all

RUN systemctl disable systemd-networkd-wait-online rdisc.service

RUN mkdir -p /var/lib/sss/pubconf/krb5.include.d/

ENTRYPOINT ["/sbin/init"]
