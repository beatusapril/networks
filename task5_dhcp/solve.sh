# -------------- DHCP server ---------------------
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
log-facility local7;
default-lease-time 3600;
max-lease-time 7200;
authoritative;

subnet 192.168.5.0 netmask 255.255.255.0 {
        option routers                  192.168.5.1;
        option subnet-mask              255.255.255.0;
        range   192.168.5.110   192.168.5.200;
}

subnet 192.168.1.0 netmask 255.255.255.0 {
        option routers                  192.168.1.2;
        option subnet-mask              255.255.255.0;
        range   192.168.1.110   192.168.1.200;
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

# edit netplan ( Ubunyu 18.04)
#  /etc/netplan/50-cloud-init.yaml
network:
    ethernets:
        enp0s9:
            dhcp4: true
    version: 2

# restart networking service

sudo netplan apply

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

