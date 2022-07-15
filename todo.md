# To Do

## Doc

## Assignment / turn in 

- do it in a virtual machine
- configuration files in associated folders
    - P1 : GNS3 configuration with Docker.
    - P2 : Discovering a VXLAN.
    - P3 :  Discovering BGP with EVPN.

## Details

### Part 1: GNS3 configuration with Docker

- install & configure GNS3 and docker in the VM
- use 2 docker images (alpine)
    - host_YOURLOGIN : containing busybox (or equiv) 
    - router_YOURLOGIN :
        - software that manages packet routing (zebra or quagga).
        - service BGPD active and configured
        - service OSPFD active and configured
        - IS-IS routing engine service
        - Busybox or an equivalent
We can use pre-build images
We can add what we want for all the required services to work
No IP address should be configured by default
We must be able to connect to them by GNS3
-> export it with zip compression including the image bases

### Part 2: Discovering a VXLAN

-> Start setting up your first VXLAN (RFC 7348) network.     
First in static then in dynamic multicast    
VXLAN : switch + X routers    
X hosts    

- configure network using a VXLAN with an ID of 10 
- set up a bridge 
- configure your ETHERNET interfaces as you wish 
- test : 
    - hostname && ifconfig eth1 && ping IP_ADDRESS
    - wireshark
- when it works : use groups -> ip -d link show vxlan10
- display mac address table : brctl showmacs br0
-> export it with zip compression including the image bases


### Part 3: Discovering BGP with EVPN

Goals
- Explore the principle of the BGP EVPN (rfc 7432) without using MPLS to simplify things.
- The controller will learn the MAC addresses. 
- We will use our VXLAN with ID 10 seen in the previous part.
Constraints
- use the principle of the route reflection (=RR)
- Our leafs (VTEP) will be configured to have dynamic relations
- see our visibility from our VTEP _wil-4 the 3 VTEPs 1.1.[1.4]
-> do sh ip route
-> do sh bgp summary
- When there is no host running we can see our VNI (10 here) as well as our preconfigured routes (type 3). No route type 2 seems to exist and it is quite normal.
-> do sh bgp l2vpn evpn
- A machine host_wil-1 is now functional. We can notice that without assigning an    
IP address our VTEP (wil_2) automatically discovers the MAC address of the functional    
machines. We can also see the automatic creation of a route type 2

- We repeat the operation with a second machine (host_wil-3). We can notice the    
second route set up by type 2. There is no assignment of IP address

- For our verification a simple ping allows us to see that we can access all the machines    
through our RR using the VTEPs. We can see the VXLAN configured to 10 as well as our    
packets ICMP. We also see packets OSPF configured    


### expected dir struct

find -maxdepth 2 -ls
424242 4 drwxr-xr-x 6 wandre wil42 4096 sept. 17 23:42 .
424242 4 drwxr-xr-x 3 wandre wil42 4096 sept. 17 23:42 ./P1
424242 4 -rw-r--r-- 1 wandre wil42 XXXX sept. 17 23:42 ./P1/P1.gns3project
424242 4 -rw-r--r-- 2 wandre wil42 XXXX sept. 17 23:42 ./P1/_wil-1_host
424242 4 -rw-r--r-- 2 wandre wil42 XXXX sept. 17 23:42 ./P1/_wil-2
424242 4 drwxr-xr-x 3 wandre wil42 4096 sept. 17 23:42 ./P2
424242 4 -rw-r--r-- 1 wandre wil42 XXXX sept. 17 23:42 ./P2/P2.gns3project
424242 4 -rw-r--r-- 2 wandre wil42 XXXX sept. 17 23:42 ./P2/wil-1_g
424242 4 -rw-r--r-- 2 wandre wil42 XXXX sept. 17 23:42 ./P2/_wil-1_host
424242 4 -rw-r--r-- 2 wandre wil42 XXXX sept. 17 23:42 ./P2/_wil-1_s
424242 4 -rw-r--r-- 2 wandre wil42 XXXX sept. 17 23:42 ./P2/_wil-2_g
424242 4 -rw-r--r-- 2 wandre wil42 XXXX sept. 17 23:42 ./P2/_wil-2_host
424242 4 -rw-r--r-- 2 wandre wil42 XXXX sept. 17 23:42 ./P2/_wil-2_s
424242 4 drwxr-xr-x 3 wandre wil42 4096 sept. 17 23:42 ./P3
424242 4 -rw-r--r-- 2 wandre wil42 4096 sept. 17 23:42 ./P3/P3.gns3project
424242 4 -rw-r--r-- 2 wandre wil42 4096 sept. 17 23:42 ./P3/_wil-1
424242 4 -rw-r--r-- 2 wandre wil42 XXXX sept. 17 23:42 ./P3/_wil-1_host
424242 4 -rw-r--r-- 2 wandre wil42 XXXX sept. 17 23:42 ./P3/_wil-2
424242 4 -rw-r--r-- 2 wandre wil42 XXXX sept. 17 23:42 ./P3/_wil-2_host
424242 4 -rw-r--r-- 2 wandre wil42 XXXX sept. 17 23:42 ./P3/_wil-3
424242 4 -rw-r--r-- 2 wandre wil42 XXXX sept. 17 23:42 ./P3/_wil-3_host
424242 4 -rw-r--r-- 2 wandre wil42 XXXX sept. 17 23:42 ./P3/_wil-4
> file P3/P3.gns3project
P3/P3.gns3project: Zip archive data, at least v2.0 to extract