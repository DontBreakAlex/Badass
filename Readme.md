# Project BADASS

The purpose of this project is to deepen your knowledge of NetPractice. You will have to simulate several networks (VXLAN+BGP-EVPN) in GNS3.

## 1. Spec projet

- on a VM
- docker + GNS3
- Folders P1, P2 and P3

### Part 1 - configure GNS3
- Install and config GNS3 on VM
- Two docker images
- one : Alpine + busybox
- two : Alpine + 
    - packet routing manager (zebra or quagga)
    - Service BGPD actif et config
    - Service OSPFD actif et config
    - IS-IS routine engine service
- No IP address should be configured by default.
- Must connect to both images via GNS3
- add the configuration files with comments to explain the set up of each equipment
- must export this project with a ZIP compression including the image bases

### Part 2 - Discovering a VXLAN / Start setting up your first VXLAN (RFC 7348) network.     
- First in static then in dynamic multicast    
- VXLAN : switch + X routers    
- X hosts    
- configure network using a VXLAN with an ID of 10 
- set up a bridge 
- configure your ETHERNET interfaces as you wish 
- test : 
    - hostname && ifconfig eth1 && ping IP_ADDRESS
    - wireshark
    - when it works : use groups -> ip -d link show vxlan10
    - display mac address table : brctl showmacs br0
- export it with zip compression including the image bases
- You must use correct and consistent names for your equipment here with the login of one of the group members.


### Part 3: Discovering BGP with EVPN

- Goals
    - Explore the principle of the BGP EVPN (rfc 7432) without using MPLS to simplify things.
    - The controller will learn the MAC addresses. 
    - We will use our VXLAN with ID 10 seen in the previous part.
- Constraints
    - use the principle of the route reflection (=RR)
    - Our leafs (VTEP) will be configured to have dynamic relations
    - see our visibility from our VTEP _wil-4 the 3 VTEPs 1.1.[1.4]
    -> do sh ip route
    -> do sh bgp summary
    - When there is no host running we can see our VNI (10 here) as well as our preconfigured routes (type 3). No route type 2 seems to exist and it is quite normal.
    -> do sh bgp l2vpn evpn
    - A machine host_wil-1 is now functional. We can notice that without assigning an    IP address our VTEP (wil_2) automatically discovers the MAC address of the functional machines. We can also see the automatic creation of a route type 2

    - We repeat the operation with a second machine (host_wil-3). We can notice the second route set up by type 2. There is no assignment of IP address

    - For our verification a simple ping allows us to see that we can access all the machines through our RR using the VTEPs. We can see the VXLAN configured to 10 as well as our packets ICMP. We also see packets OSPF configured    


### Expected dir struct

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



## 2. Concepts & technos à comprendre



| Techno / concept | Explications avec ses propres mots (en fr de preference) |
|------------------|----------------------------------------------------------|
|GNS3 (Graphical Network Simulator)|alex : émulateur de réseaux. Permet de up, configurer, tester et déboguer des machines et leurs liens. |
|VXLAN / VLAN| Qu’est ce qu’un VLAN ?<br>LAN = réseau d’ordinateurs sur la même infrastructure physique géré par un même switch / commutateur (!= hub et != routeur)<br><br>Virtual local area network = partition virtuelle d’un même LAN / sur le même switch<br>ex: un switch = 1 immeuble => 1 LAN = layer 2<br>l’immeuble a 4 appartement que je souhaite séparer<br>=> 4 VLAN<br>=> VLAN permet d’isoler des réseaux de couche 2<br>VLAN = réseau virtuel de niveau 2 ou niveau 3 OSI en surcouche d’un réseau physique<br><br>[Petite explication sur ce qu’est un switch](https://www.nowteam.net/commutateur-reseau-role-switch/) <br><br>Pourquoi VXLAN ?<br>Pour répondre aux limites techniques des VLAN (4094 max par switch car un VLAN ID est de 12 bits) pour 16 millions par VXLAN (car un VXLAN ID ou VNI est de 24 bits)<br><br>Qu’est-ce qu’un VXLAN ?<br>A la différence d’un VLAN =<br><br>Réseau virtuel de couche 2 (ethernet) - overlay - construit sur un réseau de couche 3 - underlay<br>Utilise le protocole de couche 4 UDP (User Datagram Protocol ) pour assurer la connection (tunneling entre 2 VTEP)<br>Le point de connexion entre chaque VNI se fait par un VTEP (endpoint qui encapsule/ des encapsule les paquets à la couche 2 avec un entête UDP et IP/ un VNI et une adresse MAC) <br><br>[Explications assez claires](https://networklessons.com/cisco/ccnp-encor-350-401/introduction-to-virtual-extensible-lan-vxlan) <br>[Explications plus détaillées](https://support.huawei.com/enterprise/en/doc/EDOC1100086966) |
|BGP / [BGPD](https://man.openbsd.org/bgpd)<br>(Border Gateway Protocol)|BGP = Protocole pour échanger des informations de routage<br><br>Utilise le port TCP 179 (L4)<br>[BGPD](https://man.openbsd.org/bgpd) = Le Deamon pour faire du BGP <br><br>Service Postal du Web => internet est un ensemble d’AS (autonomous system) = le plus souvent des FAI => large organisation regroupant un ensemble de router<br>=> AS = une branche / bureau postal avec ses villes, et ces milliers de boites postales => chaque routeur d’un AS = comme une boîte postale<br>BGP sert à router  le trafic en externe (entre AS) et en interne d’un AS de la façon la plus efficace possible|
|EVPN|Extension de BGP<br>Utilise MP-BGP (une extension de BGP qui supporte plus de protocoles)<br>Sert à transporter des trames ethernet (L2) avec les protocoles WAN (L4). <br><br>[Pourquoi EVPN-VXLAN](https://www.nomios.com/resources/what-is-evpn-vxlan/)<br>= permet de maintenir ensemble nouvelles et anciennes technos (qui tournent le plus souvent sur une couche OSI 2) avec la scalabilité de la couche OSI 3 <br><br>Technologie VPN all-in-one dans le sens ou elle rassemble en une solution plusieurs technologies autrefois éparpillées dans différentes solutions<br>- permet d’offrir un service ethernet multipoint<br>- crée des tables de routages en allant chercher de lui même les adresses MAC des machines à connecter et les fournis à un service de tunneling et réseau virtuel comme MPLS ou VXLAN<br>-EVPN = Control Plane vs VXLAN = Data Plane dans le sens ou EVPN dit a VXLAN comment aller d’un point A a B et VXLAN gère le transport des paquets<br>-Pour générer des Forwarding Table et alimenter VXLAN, EVPN va identifier les adresses MAC des machines du point A au point B (on parle de ‘advertisement’) <br><br>Avant EVPN, l’advertisement se faisait au niveau du Data Plane alors que le fait de pouvoir le réaliser sur le Control Plane permet par exemple d'intégrer un load balancing, une meilleure scalabilité grâce à la combinaison layer 2 et 3 OSI ou avec la fonction RR de BGP<br><br>Se distingue du modèle layer3 MPLS/VPN antérieur en ce qu’il permet d’unifier layer 2 et 3<br><br>- VXLAN <br>-- utilise un PFE (Paquet Forwarding Engine) pour décider ou envoyer les paquets<br>-- pour prendre cette décision, il utilise une Forwarding Table (FT)<br><br>EVPN (protocole BGP)<br>--la Forwarding Table (FT) est générée par un Routing Engine (RT) a partir d’une Table de Routage (RT)<br>--La Table de Routage (RT) est elle même générée avec OSPF ou autre<br><br>**EN GROS**: EVPN = un switch virtuel<br><br>[Explication de la différence entre EVPN et VXLAN](https://www.youtube.com/watch?v=cdvstTm467k) <br><br>[Synthèse de EVPN](https://blog.ipspace.net/2018/05/what-is-evpn.html)<br>[voir aussi](https://www.fiber-optic-transceiver-module.com/evpn-vs-vpls-whats-the-difference.html) <br><br>[Autre source](https://docs.vmware.com/fr/VMware-NSX-T-Data-Center/3.1/administration/GUID-D8186088-6C8F-4553-B859-B9499D9FB559.html) <br>[Route types](https://www.arista.com/en/um-eos/eos-evpn-overview?searchword=eos%20section%2010%201%20overview) |
|NLRI|NLRI = network layer reachability information<br>C’est un message envoyé dans le protocole BGP pour indiquer ce qui atteignable par l'émetteur ?<br>Exemple:<br>     /25, 204.149.16.128<br>     /23, 206.134.32<br>     /8, 10|
|L3 VPN||
|busybox|alex : Lightweight bundle of unix utilities <br>-> uses ash and sh<br>-> used to install stuff on small ressources environments (such as VMs)|
|[OSPFD](https://man.openbsd.org/ospfd)|[routing component that works with the Quagga engine](https://linux.die.net/man/8/ospfd)|
|zebra or [quagga](https://www.quagga.net/docs/quagga.pdf)|(quagga est un fork de zebra)<br>[Quagga : suite logicielle pour le routing](https://www.quagga.net/docs/quagga.pdf)<br>“update the kernel routing table so that the right data goes to the right place”<br>Comprend les daemons suivants:<br>- zebra: Manager de routing d’IP. Déclaration des interfaces, routage statique, et redistribution des toutes entre les différents protocoles<br>- bgpd:Protocole de routage BGP<br>- ospfd:Protocole de routage OSPF<br>- ospf6d:Protocole de routage OSPF pour IPv6<br>- ripd:Protocole de routage RIP v2<br>- RIP (Routing Information Protocol)<br>- ripngd:	Protocole de routage RIP pour Ipv6<br><br>-> all will work together to build the routing table<br>-> integrated user interface shell called vtysh<br><br>-> install with apt|
|IS-IS routine engine service<br>(Intermediate System to Intermediate System)|IS-IS = protocole de routage interne (IGP -> Internal Gateway Protocol) qui respose sur une collection de ‘link-state’ (information de routage généré par l'échange d’informations entre les routeurs voisins -> système dit de neighboring ). Ces informations de link-state (topologie du réseau) sont transmises à tous les routeurs d’un même AS par flooding (chaque routeurs transmets toutes les informations de topologie à ses voisins)<br><br>Le protocole OSPF repose sur le même principe de link-state et de flooding.<br>La principale différence entre les deux est que OSPF fonctionne en layer 3 OSI tandis que IS-IS fonctionne en layer 2 OSI<br><br>cd [ce lien](https://www.metaswitch.com/knowledge-center/reference/what-is-intermediate-system-to-intermediate-system-isis) <br><br>[Differencce OSPF vs ISIS](https://forum.huawei.com/enterprise/en/ospf-vs-isis/thread/570007-861) |
|static / dynamic multicast||
|MPLS|MPLS = Multiprotocol Label Switching<br>Mécanisme de routage reposant sur des labels<br>Utilise le layer 2 pour transporter à peu prêt tout, comme des trames ethernet ou IP<br>|
|MAC addresses||
|route reflection (RR)<br>route distinguisher (RD)<br>route targets (RTs)<br>|Dans un cluster de machine ou Autonomous System (AS), pour que les routeurs puissent échanger entre eux, on utilise traditionnellement un mesh (maillage) de routeurs => chaque routeurs connaît tous les autres => probleme = tres lourd et peu scalable<br>Route Reflexion = fonctionnalité BGP qui consiste à désigner un routeur en tant que RR => devient point de référence de tous ou d’un groupe de routeurs pour communiquer entre eux<br>cd [cet article](https://networklessons.com/bgp/bgp-route-reflector) |
|leafs / VTEP (VXLAN tunnel endpoint)|endpoint qui encapsule/ des encapsule les paquets à la couche 2 avec un entête UDP et IP/ un VNI et une adresse MAC<br>Peut etre logiciel ou matériel|
|OSPF (Open Shortest Path First)||
|VNI|VXLAN ID (VNI) = VLAN ID mais pour VXLAN = correspond à l'identifiant d’un réseau virtuel sous VXLAN|
|ICMP|Protocole L4 (comme UDP et TCP) qui sert non pas à envoyer des données mais des messages. Exemple: ping. Sert généralement à signaler une erreur|
|Couche 2 et 3 modele OSI<br>[wiki](https://fr.wikipedia.org/wiki/Mod%C3%A8le_OSI) |Petit rappel:<br>- layer 2 = Liaison / adressage physique (MAC)<br>- layer 3 = Réseau / adressage logique (IP)<br>- layer 4 = Transport / UDP ou TCP




## 3.Sources utiles

- [gns3 (official website)](https://www.gns3.com/)
- [Wireshark (network tool)](https://www.wireshark.org/download.html) : analyse l’activité réseau
- BGP ([RFC 4271](https://datatracker.ietf.org/doc/html/rfc4271))
    - [Wiki](https://en.wikipedia.org/wiki/Border_Gateway_Protocol)
    - [Fireware](https://www.watchguard.com/help/docs/fireware/12/fr-FR/Content/fr-FR/dynamicrouting/bgp_about_c.html#:~:text=Le%20protocole%20BGP%20(Border%20Gateway,partager%20des%20informations%20de%20routage.)
- VXLAN (RFC 7348)
    - [Wiki](https://en.wikipedia.org/wiki/Virtual_Extensible_LAN)
    - [Juniper](https://www.juniper.net/fr/fr/research-topics/what-is-vxlan.html)
    - [Un random qui en parle](https://vincent.bernat.ch/en/blog/2017-vxlan-linux#unicast-with-static-flooding)
- [OSPFD](https://man.openbsd.org/ospfd) / [BGPD](https://man.openbsd.org/bgpd)
- [Image docker dont semble parler la partie 1 du sujet](https://hub.docker.com/r/osrg/quagga/tags)
- [Sources de l’image docker](https://github.com/osrg/dockerfiles/tree/master/quagga)
- [FRR](http://docs.frrouting.org/en/latest/overview.html#system-architecture)
- [Redhat virtual interfaces in linux](https://developers.redhat.com/blog/2018/10/22/introduction-to-linux-interfaces-for-virtual-networking#vxlan)
- [VXLAN in Linux](https://vincent.bernat.ch/en/blog/2017-vxlan-linux)
- [Kernel.org doc on VXLAN](https://www.kernel.org/doc/Documentation/networking/vxlan.txt)
- [IP cheat sheet](https://access.redhat.com/sites/default/files/attachments/rh_ip_command_cheatsheet_1214_jcs_print.pdf)

- Documentation interfaces
    - [github gns3-lab vxlan-lab](https://github.com/GeneralFox/gns3-lab/blob/master/vxlan-lab/dc-sec-l2edge )
    - [wiki alpine Vlan](https://wiki.alpinelinux.org/wiki/Vlan) 
    - [FAQ cyberciti setup network interfaces files](https://www.cyberciti.biz/faq/setting-up-an-network-interfaces-file/ )
    - [wiki Debian network config](https://wiki.debian.org/NetworkConfiguration )
    - [man interfaces](https://man.developpez.com/man5/interfaces/) 
    - [Git kernelsmith](https://gist.github.com/kernelsmith/a8d30c2e9a561b4522ec) 
    - [another git](https://gist.github.com/DazWorrall/e4d0c9d7f1a417da8022 )

4. VM
Dld la vm :
```
bash init.sh
```
Creer une VM debian dans virt-manager:
- File > Add connection > User session
- File > New VM > Network > Paste ```http://deb.debian.org/debian/dists/buster/main/installer-amd64/``` > Forward
    - if using existing image
		File > New VM > import existing image > forward > /goinfre/$USER/debian.qcow2 (OS : Generic default) > Memory 2048 / CPU 2
		Credentials : user / user
		launch gns3 in terminal (‘gns3’)
- Follow instructions
- sudo apt install spice-vdagent
- To resize screen xrandr --output Virtual-0 --auto

## 4. Etapes
- Etapes de la partie 1
    - Creer une VM debian
    - [Suivre instructions pour debian buster](https://docs.gns3.com/docs/getting-started/installation/linux/)
    - (Si necessaire) Ajouter /home/user/.local/bin au PATH
    - Reboot
    - Lancer gns3 avec la commande gns3
    - Creer un projet (remplir la popup)
        - [Suivre les instructions de gns3 pour docker](https://docs.gns3.com/docs/emulators/docker-support-in-gns3/) (ajouter les images alpine:latest et ghcr.io/dontbreakalex/badass-frr:latest) (Le dockerfile de la 2e image est dans le repo git)
    - Cliquer sur browse devices (panneau de droite) et glisser les images dans la topologie
    - Renommer les devices
    - Export portable project

- Étapes de la partie 2
    - brctl addbr br0 = creer un bridge
    - brctl addif br0 eth1 sur chaque machine = créer un brigde dans le routeur
        - brctl show br0 pour voir bridge
        - brctl showmacs br0 pour voir les adresses mac

    - ip addr add 192.168.1.1/24 (ou 2 pour le 2e routeur) dev eth0 = créer une adresse ip statique pour chaque routeur (en précisant l’interface => eth0 dans l’exemple)
        - pour vérifier ip a ou ping de l’autre routeur

    - ip link add vxlan10 type vxlan id 10  local  192.168.1.1 remote  192.168.1.2 dev eth0 dstport 4789 => a faire sur chaque machine en inversant la ref des ips
        - ip a pour vérifier
        - ip link del vxlan10 pour supprimer

    - répéter la même commande qu’en 2. avec vxlan10  au lieu de eth1 en tant que device cible a bridge => les routeurs sont à présent bridges avec le VLXAN nomme vxlan10 que l’on a créé

    - ip link set br0 up => activer le bridge
        - repeter avec vxlan10

    - répéter la commande 3. pour chaque host sur son interface (eth0 dans notre cas) pour leur donner une ip statique 30.1.1.1 (ou 2)
        - ifconfig eth0 pour vérifier la config

    - A ce stade le VXLAN est set statiquement, sans groupe. Les hosts peuvent à présent communiquer entre eux via le VXLAN. Pour vérifier:
        - depuis un host, ping l’autre
        - Sous gns3 cliquer sur un lien entre un routeur et le switch et cliquer sur “start capture” => lancer wireshark => filtrer sous ICMP pour mieux observer l’encapsulation des différents réseaux

- Étapes de la partie 3
    - [Ahmad Nadeem MVP](https://www.youtube.com/watch?v=Ek7kFDwUJBM)
    - vtysh
    - config t 
    - ctrl-c ctrl-v FRRouting config file
    - configure vxlan