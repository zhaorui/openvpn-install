#!/bin/bash

echo "auth-user-pass-verify /etc/openvpn/checkpsw.sh via-env
username-as-common-name" >> /etc/openvpn/server.conf

cp ./checkpsw.sh /etc/openvpn/checkpsw.sh

chmod 755 /etc/openvpn/checkpsw.sh

touch /etc/openvpn/psw-file
echo "user1 pass1 # 用户名 密码以空格隔开
user2 pass2" >> /etc/openvpn/psw-file

chmod 400 /etc/openvpn/psw-file

# restart openvpn
if pgrep systemd-journal; then
    systemctl restart openvpn@server.service
    systemctl enable openvpn@server.service
else
    service openvpn restart
    chkconfig openvpn on
fi