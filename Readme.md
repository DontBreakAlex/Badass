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
    -> ```do sh ip route```
    -> ```do sh bgp summary```
    - When there is no host running we can see our VNI (10 here) as well as our preconfigured routes (type 3). No route type 2 seems to exist and it is quite normal.
    -> do sh bgp l2vpn evpn
    - A machine host_wil-1 is now functional. We can notice that without assigning an IP address to our VTEP (wil_2) it will automatically discovers the MAC address of the functional machines. We can also see the automatic creation of a route type 2

    - We repeat the operation with a second machine (host_wil-3). We can notice the second route set up by type 2. There is no assignment of IP address

    - For our verification a simple ping allows us to see that we can access all the machines through our RR using the VTEPs. We can see the VXLAN configured to 10 as well as our packets ICMP. We also see packets OSPF configured    

## 2. Concepts & technos ?? comprendre



| Techno / concept | Explications avec ses propres mots (en fr de preference) |
|------------------|----------------------------------------------------------|
|GNS3 (Graphical Network Simulator)|??mulateur de r??seaux. Permet de up, configurer, tester et d??boguer des machines et leurs liens. |
|VXLAN / VLAN| Qu???est ce qu???un VLAN ?<br>LAN = r??seau d???ordinateurs sur la m??me infrastructure physique g??r?? par un m??me switch / commutateur (!= hub et != routeur)<br><br>Virtual local area network = partition virtuelle d???un m??me LAN / sur le m??me switch<br>ex: un switch = 1 immeuble => 1 LAN = layer 2<br>l???immeuble a 4 appartement que je souhaite s??parer<br>=> 4 VLAN<br>=> VLAN permet d???isoler des r??seaux de couche 2<br>VLAN = r??seau virtuel de niveau 2 ou niveau 3 OSI en surcouche d???un r??seau physique<br><br>[Petite explication sur ce qu???est un switch](https://www.nowteam.net/commutateur-reseau-role-switch/) <br><br>Pourquoi VXLAN ?<br>Pour r??pondre aux limites techniques des VLAN (4094 max par switch car un VLAN ID est de 12 bits) pour 16 millions par VXLAN (car un VXLAN ID ou VNI est de 24 bits)<br><br>Qu???est-ce qu???un VXLAN ?<br>A la diff??rence d???un VLAN =<br><br>R??seau virtuel de couche 2 (ethernet) - overlay - construit sur un r??seau de couche 3 - underlay<br>Utilise le protocole de couche 4 UDP (User Datagram Protocol ) pour assurer la connection (tunneling entre 2 VTEP)<br>Le point de connexion entre chaque VNI se fait par un VTEP (endpoint qui encapsule/ des encapsule les paquets ?? la couche 2 avec un ent??te UDP et IP/ un VNI et une adresse MAC) <br><br>[Explications assez claires](https://networklessons.com/cisco/ccnp-encor-350-401/introduction-to-virtual-extensible-lan-vxlan) <br>[Explications plus d??taill??es](https://support.huawei.com/enterprise/en/doc/EDOC1100086966) |
|BGP / [BGPD](https://man.openbsd.org/bgpd)<br>(Border Gateway Protocol)|BGP = Protocole pour ??changer des informations de routage<br><br>Utilise le port TCP 179 (L4)<br>[BGPD](https://man.openbsd.org/bgpd) = Le Deamon pour faire du BGP <br><br>Service Postal du Web => internet est un ensemble d???AS (autonomous system) = le plus souvent des FAI => large organisation regroupant un ensemble de router<br>=> AS = une branche / bureau postal avec ses villes, et ces milliers de boites postales => chaque routeur d???un AS = comme une bo??te postale<br>BGP sert ?? router  le trafic en externe (entre AS) et en interne d???un AS de la fa??on la plus efficace possible|
|EVPN|Extension de BGP<br>Utilise MP-BGP (une extension de BGP qui supporte plus de protocoles)<br>Sert ?? transporter des trames ethernet (L2) avec les protocoles WAN (L4). <br><br>[Pourquoi EVPN-VXLAN](https://www.nomios.com/resources/what-is-evpn-vxlan/)<br>= permet de maintenir ensemble nouvelles et anciennes technos (qui tournent le plus souvent sur une couche OSI 2) avec la scalabilit?? de la couche OSI 3 <br><br>Technologie VPN all-in-one dans le sens ou elle rassemble en une solution plusieurs technologies autrefois ??parpill??es dans diff??rentes solutions<br>- permet d???offrir un service ethernet multipoint<br>- cr??e des tables de routages en allant chercher de lui m??me les adresses MAC des machines ?? connecter et les fournis ?? un service de tunneling et r??seau virtuel comme MPLS ou VXLAN<br>-EVPN = Control Plane vs VXLAN = Data Plane dans le sens ou EVPN dit a VXLAN comment aller d???un point A a B et VXLAN g??re le transport des paquets<br>-Pour g??n??rer des Forwarding Table et alimenter VXLAN, EVPN va identifier les adresses MAC des machines du point A au point B (on parle de ???advertisement???) <br><br>Avant EVPN, l???advertisement se faisait au niveau du Data Plane alors que le fait de pouvoir le r??aliser sur le Control Plane permet par exemple d'int??grer un load balancing, une meilleure scalabilit?? gr??ce ?? la combinaison layer 2 et 3 OSI ou avec la fonction RR de BGP<br><br>Se distingue du mod??le layer3 MPLS/VPN ant??rieur en ce qu???il permet d???unifier layer 2 et 3<br><br>- VXLAN <br>-- utilise un PFE (Paquet Forwarding Engine) pour d??cider ou envoyer les paquets<br>-- pour prendre cette d??cision, il utilise une Forwarding Table (FT)<br><br>EVPN (protocole BGP)<br>--la Forwarding Table (FT) est g??n??r??e par un Routing Engine (RT) a partir d???une Table de Routage (RT)<br>--La Table de Routage (RT) est elle m??me g??n??r??e avec OSPF ou autre<br><br>**EN GROS**: EVPN = un switch virtuel<br><br>[Explication de la diff??rence entre EVPN et VXLAN](https://www.youtube.com/watch?v=cdvstTm467k) <br><br>[Synth??se de EVPN](https://blog.ipspace.net/2018/05/what-is-evpn.html)<br>[voir aussi](https://www.fiber-optic-transceiver-module.com/evpn-vs-vpls-whats-the-difference.html) <br><br>[Autre source](https://docs.vmware.com/fr/VMware-NSX-T-Data-Center/3.1/administration/GUID-D8186088-6C8F-4553-B859-B9499D9FB559.html) <br>[Route types](https://www.arista.com/en/um-eos/eos-evpn-overview?searchword=eos%20section%2010%201%20overview) |
|NLRI|NLRI = network layer reachability information<br>C???est un message envoy?? dans le protocole BGP pour indiquer ce qui atteignable par l'??metteur <br>Exemple:<br>     ```/25, 204.149.16.128```<br>     ```/23, 206.134.32```<br>     ```/8, 10```|
|busybox|Lightweight bundle of unix utilities <br>-> uses ash and sh<br>-> used to install stuff on small ressources environments (such as VMs)|
|[OSPFD](https://man.openbsd.org/ospfd)|[routing component that works with the Quagga engine](https://linux.die.net/man/8/ospfd)|
|zebra or [quagga](https://www.quagga.net/docs/quagga.pdf)|(quagga est un fork de zebra)<br>[Quagga : suite logicielle pour le routing](https://www.quagga.net/docs/quagga.pdf)<br>???update the kernel routing table so that the right data goes to the right place???<br>Comprend les daemons suivants:<br>- zebra: Manager de routing d???IP. D??claration des interfaces, routage statique, et redistribution des toutes entre les diff??rents protocoles<br>- bgpd:Protocole de routage BGP<br>- ospfd:Protocole de routage OSPF<br>- ospf6d:Protocole de routage OSPF pour IPv6<br>- ripd:Protocole de routage RIP v2<br>- RIP (Routing Information Protocol)<br>- ripngd:	Protocole de routage RIP pour Ipv6<br><br>-> all will work together to build the routing table<br>-> integrated user interface shell called vtysh<br><br>-> install with apt|
|IS-IS routine engine service<br>(Intermediate System to Intermediate System)|IS-IS = protocole de routage interne (IGP -> Internal Gateway Protocol) qui respose sur une collection de ???link-state??? (information de routage g??n??r?? par l'??change d???informations entre les routeurs voisins -> syst??me dit de neighboring ). Ces informations de link-state (topologie du r??seau) sont transmises ?? tous les routeurs d???un m??me AS par flooding (chaque routeurs transmets toutes les informations de topologie ?? ses voisins)<br><br>Le protocole OSPF repose sur le m??me principe de link-state et de flooding.<br>La principale diff??rence entre les deux est que OSPF fonctionne en layer 3 OSI tandis que IS-IS fonctionne en layer 2 OSI<br><br>cd [ce lien](https://www.metaswitch.com/knowledge-center/reference/what-is-intermediate-system-to-intermediate-system-isis) <br><br>[Differencce OSPF vs ISIS](https://forum.huawei.com/enterprise/en/ospf-vs-isis/thread/570007-861) |
|MPLS|MPLS = Multiprotocol Label Switching<br>M??canisme de routage reposant sur des labels<br>Utilise le layer 2 pour transporter ?? peu pr??t tout, comme des trames ethernet ou IP<br>|
|route reflection (RR)<br>route distinguisher (RD)<br>route targets (RTs)<br>|Dans un cluster de machine ou Autonomous System (AS), pour que les routeurs puissent ??changer entre eux, on utilise traditionnellement un mesh (maillage) de routeurs => chaque routeurs conna??t tous les autres => probleme = tres lourd et peu scalable<br>Route Reflexion = fonctionnalit?? BGP qui consiste ?? d??signer un routeur en tant que RR => devient point de r??f??rence de tous ou d???un groupe de routeurs pour communiquer entre eux<br>cd [cet article](https://networklessons.com/bgp/bgp-route-reflector) |
|leafs / VTEP (VXLAN tunnel endpoint)|endpoint qui encapsule/ des encapsule les paquets ?? la couche 2 avec un ent??te UDP et IP/ un VNI et une adresse MAC<br>Peut etre logiciel ou mat??riel|
|VNI|VXLAN ID (VNI) = VLAN ID mais pour VXLAN = correspond ?? l'identifiant d???un r??seau virtuel sous VXLAN|
|ICMP|Protocole L4 (comme UDP et TCP) qui sert non pas ?? envoyer des donn??es mais des messages. Exemple: ping. Sert g??n??ralement ?? signaler une erreur|
|Couche 2 et 3 modele OSI<br>[wiki](https://fr.wikipedia.org/wiki/Mod%C3%A8le_OSI) |Petit rappel:<br>- layer 2 = Liaison / adressage physique (MAC)<br>- layer 3 = R??seau / adressage logique (IP)<br>- layer 4 = Transport / UDP ou TCP




## 3.Sources utiles

- [gns3 (official website)](https://www.gns3.com/)
- [Wireshark (network tool)](https://www.wireshark.org/download.html) : analyse l???activit?? r??seau
- BGP ([RFC 4271](https://datatracker.ietf.org/doc/html/rfc4271))
    - [Wiki](https://en.wikipedia.org/wiki/Border_Gateway_Protocol)
    - [Fireware](https://www.watchguard.com/help/docs/fireware/12/fr-FR/Content/fr-FR/dynamicrouting/bgp_about_c.html#:~:text=Le%20protocole%20BGP%20(Border%20Gateway,partager%20des%20informations%20de%20routage.)
- VXLAN (RFC 7348)
    - [Wiki](https://en.wikipedia.org/wiki/Virtual_Extensible_LAN)
    - [Juniper](https://www.juniper.net/fr/fr/research-topics/what-is-vxlan.html)
    - [Un random qui en parle](https://vincent.bernat.ch/en/blog/2017-vxlan-linux#unicast-with-static-flooding)
- [OSPFD](https://man.openbsd.org/ospfd) / [BGPD](https://man.openbsd.org/bgpd)
- [Image docker dont semble parler la partie 1 du sujet](https://hub.docker.com/r/osrg/quagga/tags)
- [Sources de l???image docker](https://github.com/osrg/dockerfiles/tree/master/quagga)
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
		launch gns3 in terminal (???gns3???)
- Follow instructions
- ```sudo apt install spice-vdagent```
- To resize screen ```xrandr --output Virtual-0 --auto```

## 4. Etapes
- Etapes de la partie 1
    - Creer une VM debian
    - [Suivre instructions pour debian buster](https://docs.gns3.com/docs/getting-started/installation/linux/)
    - (Si necessaire) Ajouter ```/home/user/.local/bin``` au PATH
    - Reboot
    - Lancer gns3 avec la commande gns3
    - Creer un projet (remplir la popup)
        - [Suivre les instructions de gns3 pour docker](https://docs.gns3.com/docs/emulators/docker-support-in-gns3/) (ajouter les images ```alpine:latest et ghcr.io/dontbreakalex/badass-frr:latest```) (Le dockerfile de la 2e image est dans le repo git)
    - Cliquer sur browse devices (panneau de droite) et glisser les images dans la topologie
    - Renommer les devices
    - Export portable project

- ??tapes de la partie 2
    - ```brctl addbr br0``` = creer un bridge
    - ```brctl addif br0 eth1``` sur chaque machine = cr??er un brigde dans le routeur
        - ```brctl show br0``` pour voir bridge
        - ```brctl showmacs br0``` pour voir les adresses mac

    - ```ip addr add 192.168.1.1/24 dev eth0``` (ou 2 pour le 2e routeur)  = cr??er une adresse ip statique pour chaque routeur (en pr??cisant l???interface => eth0 dans l???exemple)
        - pour v??rifier ```ip a``` ou ```ping``` de l???autre routeur

    - ```ip link add vxlan10 type vxlan id 10 local 192.168.1.1 remote 192.168.1.2 dev eth0 dstport 4789``` => a faire sur chaque machine en inversant la ref des ips
        - ```ip a``` pour v??rifier
        - ```ip link del vxlan10``` pour supprimer

    - r??p??ter la m??me commande qu???en 2. avec vxlan10  au lieu de eth1 en tant que device cible a bridge => les routeurs sont ?? pr??sent bridges avec le VLXAN nomme vxlan10 que l???on a cr????

    - ```ip link set br0 up``` => activer le bridge
        - repeter avec vxlan10

    - r??p??ter la commande 3. pour chaque host sur son interface (eth0 dans notre cas) pour leur donner une ip statique ```30.1.1.1``` (ou 2)
        - ```ifconfig eth0``` pour v??rifier la config

    - A ce stade le VXLAN est set statiquement, sans groupe. Les hosts peuvent ?? pr??sent communiquer entre eux via le VXLAN. Pour v??rifier:
        - depuis un host, ping l???autre
        - Sous gns3 cliquer sur un lien entre un routeur et le switch et cliquer sur ???start capture??? => lancer wireshark => filtrer sous ICMP pour mieux observer l???encapsulation des diff??rents r??seaux

- ??tapes de la partie 3
	- Pourquoi pas d'impl??mentation MPLS ?
		- MPLS est un protocole pour acc??l??rer le trafic r??seau, dans notre cas cela ajouterai en complexit?? sans utilit??, un EVPN avec un VXLAN ??tant largement suffisant en l'??tat.
	- Pour chaque routeur, cr??er un bridge br0 et un VXLAN vxlan10 comme dans la partie 2 => fait par le script vxlan.sh 
		- ce script est ajout?? au script de lancement qui appara??t en CMD en entr??e de l???image officielle Docker FRR qui nous sert a faire tourner nos routeurs
		- Une seule diff??rence ! Contrairement ?? la partie 2, les feuilles / VTEPS (endpoint VXLAN) c???est a dire les interfaces des routeurs reli??s par le VXLAN sont d??termin??es / set dynamiquement et non de fa??on statique (on n???indique pas une adresse local et remote ni un group multicast)
	- Lors de la premi??re config des routeurs =
		- ouvrir un auxiliary terminal
		- ```vtysh``` -> message ???Can???t open configuration file /etc/frr/vtysh.conf due to ???No such fie or directory???. ??? ???
			=> we???re in vtysh terminal (prompt changed from ???/ #??? to ???_aseo-4#???)
		- type ```conf t``` to enter config informations
		- pour sauvegarder la config taper ```do write```
		- Ensuite, toujours sous vtysh taper :
			- ```do sh ip route``` = voir les autres VTEP configur??s
			- ```do sh bgp summary``` = voir les routes entre le VTEP et le RR
			- ```do sh bgp l2vpn evpn``` = lance le rep??rage des adresses mac des ??quipements et cr??e :
				- une route de type 3 pour chaque VNI local,
				- une route de type 2 pour chaque adresse MAC locale.
		- Une fois la commande ```do sh bgp l2vpn evpn``` lanc??e, une route entre tous les ??quipements est cr????e et l???adressage dynamique du VXLAN est effectu?? (attendre un peu - cela peut prendre un peu de temps). Les hosts peuvent ?? pr??sent communiquer entre eux via le VXLAN. Pour v??rifier:
			- depuis un host, ```ping``` l???autre
			- Sous gns3 cliquer sur un lien entre un routeur et le switch et cliquer sur ???start capture??? => lancer wireshark => filtrer sous ICMP pour mieux observer l???encapsulation des diff??rents r??seaux
