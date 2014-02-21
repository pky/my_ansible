#!/bin/bash

#iptables
IPT=/sbin/iptables

# インタフェース名定義
LOCAL_DEV=eth1

#バックセグメント
#BACK_SEG=172.10.0.0/16

/etc/rc.d/init.d/iptables stop

#初期化
$IPT -F
$IPT -X
$IPT -Z

$IPT -P INPUT   DROP
$IPT -P OUTPUT  ACCEPT
$IPT -P FORWARD DROP

# 自ホストからのアクセスをすべて許可
$IPT -A INPUT -i lo -j ACCEPT

# icmpはすべて許可
$IPT -A INPUT -p icmp --icmp-type any -j ACCEPT

# ssh許可（vagrant開発環境用）
$IPT -A INPUT -p tcp --dport 22 -j ACCEPT

#https
$IPT -A INPUT -p tcp --dport 80 -j ACCEPT
$IPT -A INPUT -p tcp --dport 443 -j ACCEPT

# 内部からのアクセスをすべて許可
#$IPT -A INPUT  -i $LOCAL_DEV -p all -s $BACK_SEG -j ACCEPT

# 内部から行ったアクセスに対する外部からの返答アクセスを許可
$IPT -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

$IPT -N LOGGING
$IPT -A LOGGING -j LOG --log-level debug --log-prefix "DROP:" -m limit
$IPT -A LOGGING -j DROP
$IPT -A INPUT  -j LOGGING

# 上記のルールにマッチしなかったアクセスはreject応答
$IPT -A INPUT -j REJECT --reject-with icmp-host-prohibited
$IPT -A FORWARD -j REJECT --reject-with icmp-host-prohibited

/etc/init.d/iptables save
/etc/init.d/iptables start
