#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
sed -i 's/192.168.1.1/192.168.1.2/g' package/base-files/files/bin/config_generate

# --------------- 自定义部分 ---------------
# 修改默认主题
$WRT_THEME=argon
sed -i "s/luci-theme-bootstrap/luci-theme-$WRT_THEME/g" $(find ./feeds/luci/collections/ -type f -name "Makefile")
## 配置文件修改 或手动添加
#echo "CONFIG_PACKAGE_luci-theme-$WRT_THEME=y" >> ./.config
#echo "CONFIG_PACKAGE_luci-app-$WRT_THEME-config=y" >> ./.config

CFG_FILE="./package/base-files/files/bin/config_generate"

# 修改默认主机名
sed -i "s/hostname='.*'/hostname='OpenWrt'/g" $CFG_FILE
# 修改默认时区
sed -i "s/timezone='.*'/timezone='CST-8'/g" $CFG_FILE
sed -i "/timezone='.*'/a\\\t\t\set system.@system[-1].zonename='Asia/Shanghai'" $CFG_FILE

# 修改默认WIFI名
sed -i "s/ssid=.*/ssid=冰糖/g" ./package/kernel/mac80211/files/lib/wifi/mac80211.sh

# ddns-go软件
git clone https://github.com/sirpdboy/luci-app-ddns-go.git package/ddns-go

# --------------- end ---------------

