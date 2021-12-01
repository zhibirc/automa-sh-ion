#!/usr/bin/env bash
# -----------------------------------------
# Simple and shallow network resource test.
# -----------------------------------------

readonly URL="$1"

[[ -z "$URL" ]] && printf %s\\n 'URL is absent, please specify it as an argument.' && exit 1

printf %s\\n '---------- CURL ----------'
curl -kso /dev/null "$URL" -w "
| DNSLookup: %{time_namelookup}\n
| Connect: %{time_connect}\n
| AppConnect: %{time_appconnect}\n
| Pretransfer: %{time_pretransfer}\n
| Starttransfer: %{time_starttransfer}\n
| Total: %{time_total}\n
| Size: %{size_download}\n
| HTTPCode=%{http_code}\n\n"

printf %b\\n\\n "\n---------- TRACEROUTE ----------"
traceroute -v -m 12 "$URL"

printf %b\\n\\n "\n---------- PING ----------"
ping -v -t 4 "$URL"

printf %b\\n\\n "\n---------- NMAP ----------"
nmap -vv -T4 -p 22,80,443 --reason "$URL"

printf %b\\n\\n "\n---------- DIG ----------"
dig "$URL" any

exit 0
