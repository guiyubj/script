#!/bin/sh

: <<'END'
Copyright (c) 2015, 2016 Rafał Pocztarski
Copyright (c) 2017 Yu Gui 

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


get external IP address
used for outgoing Internet connections
see: https://github.com/rsp/scripts/blob/master/externalip.md
END

case "$1" in
	# upload the external ip addr to NY1 server
	upload) dig +short myip.opendns.com @resolver1.opendns.com > ~/conf/extip.txt
		echo 'extip from server: ' >> ~/conf/extip.txt
		curl -s http://ipinfo.io/ip >> ~/conf/extip.txt
		curl -s https://4.ifcfg.me/ >> ~/conf/extip.txt
		scp ~/conf/extip.txt root@45.55.192.222:conf/yu-ws1-extip.txt
		;;

	""|dns)	dig +short myip.opendns.com @resolver1.opendns.com ;;
	ipinfo) curl -s http://ipinfo.io/ip ;;
	http) curl -s http://whatismyip.akamai.com/ && echo ;;
	https) curl -s https://4.ifcfg.me/ ;;
	ftp) echo close | ftp 4.ifcfg.me | awk '{print $4; exit}' ;;
	telnet) nc 4.ifcfg.me 23 | grep IPv4 | cut -d' ' -f4 ;;
	*) echo Bad argument >&2 && exit 1 ;;
esac


