killall dnsmasq
killall hostapd
killall lighttpd
sysctl -w net.ipv4.conf.all.forwarding=0
ip addr flush dev wlan1
iptables -F -t nat

