FROM frrouting/frr:v8.2.2

# Enable required deamons
RUN sed -i s/bgpd=no/bgpd=yes/g /etc/frr/daemons && \
    sed -i s/ospfd=no/ospfd=yes/g /etc/frr/daemons && \
    sed -i s/isisd=no/isisd=yes/g /etc/frr/daemons && \
    sed -i s/ospfd=no/ospfd=yes/g /etc/frr/daemons

# Directory in volume for leaf's frr config persistence
VOLUME /etc/frr

# Addind vlan'script in dockerfile's starting script 
RUN sed '18isource /etc/frr/vxlan.sh' /usr/lib/frr/docker-start > temp && mv temp /usr/lib/frr/docker-start && chmod +x /usr/lib/frr/docker-start
