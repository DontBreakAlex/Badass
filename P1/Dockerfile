FROM frrouting/frr:v8.2.2

# Enable required deamons
RUN sed -i s/bgpd=no/bgpd=yes/g /etc/frr/daemons && \
    sed -i s/ospfd=no/ospfd=yes/g /etc/frr/daemons && \
    sed -i s/isisd=no/isisd=yes/g /etc/frr/daemons && \
    sed -i s/ospfd=no/ospfd=yes/g /etc/frr/daemons

