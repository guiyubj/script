import requests
import time

str_user = "aaronk199"
str_pwd = "223b0384556ef70e431309e513141335"
str_ip_check = "http://ipinfo.io/ip"
str_ip_update = "http://api.dynu.com/nic/update?"
i_delay = 8 # seconds of delay between each refresh


print("Getting current IP...")
resp_ip = requests.get(str_ip_check)

if not resp_ip.status_code == 200:
    raise "Cannot get IP addr from "+str_ip_check
    pass
else:
    str_ip = resp_ip.text
    print("IP: "+str_ip)

print("Updating remote IP addr...")
# dynu.com ip update api:
# http://api.dynu.com/nic/update?hostname=[HOSTNAME]&alias=[ALIA]&myip=[IP ADDRESS]&myipv6=[IPv6 ADDRESS]&password=[PASSWORD or MD5(PASSWORD)]

resp_update = requests.get(str_ip_update, params = {"myip":str_ip, "username":str_user, "password":str_pwd})

if not resp_update.status_code == 200:
    raise "Cannot update IP addr to "+str_ip_update
    pass
else:
    str_ip = resp_update.text
    print("Resp: "+resp_update.text +'\n')
