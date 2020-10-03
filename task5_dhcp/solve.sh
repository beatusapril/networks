# -------------- DCHP server ---------------------
# install isc-dhcp-server
sudo apt install isc-dhcp-server
# add interface which will listen dchp process
sudo nano /etc/default/isc-dhcp-server

add -->
INTERFACESv4="enp0s10"
INTERFACESv6=""

# add settings dchp server ( router, network )
 nano /etc/dhcp/dhcpd.conf

# add follow rows
# first row for dchp log
echo 'log-facility local7;' >> /etc/dhcp/dhcpd.conf
option domain-name "example.org";
option domain-name-servers ns1.example.org, ns2.example.org;

default-lease-time 600;
max-lease-time 7200;

ddns-update-style none;

authoritative;
subnet 192.168.5.0 netmask 255.255.255.0 {
        option routers                  192.168.5.1;
        option subnet-mask              255.255.255.0;
        option domain-search            " merionet.ru ";
        option domain-name-servers      192.168.5.1;
        range 192.168.5.10   192.168.5.100;
        range 192.168.5.110  192.168.5.200;
}

# add ip address router
sudo nano /etc/network/interfaces
# and add following rows
auto enp0s10
iface enp0s10 inet static
address 192.168.5.1
netmask 255.255.255.0

# start and enable dchp
/etc/init.d/isc-dhcp-server start
/etc/init.d/isc-dhcp-server restart
/etc/init.d/isc-dhcp-server enable

# if need allow 67 port
sudo ufw allow 67/udp
sudo ufw reload


# ------- DCHP CLIENT ----------------

# add default gateway on interface with dchp 
# ip addres router is ip address gateway
sudo nano /etc/network/interfaces
# add follow rows
auto enp0s9
iface enp0s9 inet dhcp
gateway 192.168.5.1
netmask 255.255.255.192

# restart networking service

sudo systemctl restart networking

# repeat on hostB

# add log dchp
# create file /etc/rsyslog.d/dhcpd.conf with rows
echo 'local7.* /var/log/dhcpd.log' > /etc/rsyslog.d/dhcpd.conf
echo '& ~' >> /etc/rsyslog.d/dhcpd.conf

# restart domen dchp and rsyslog
/etc/init.d/isc-dhcp-server restart
/etc/init.d/rsyslog restart

# check log in file /var/log/dhcpd.log


# ---  CHECK 
ip addr

# see log /var/log/dhcpd.log

