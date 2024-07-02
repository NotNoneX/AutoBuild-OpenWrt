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
# 配置文件修改 主题及主题配置
# echo "CONFIG_PACKAGE_luci-theme-$WRT_THEME=y" >> ./.config
# echo "CONFIG_PACKAGE_luci-app-$WRT_THEME-config=y" >> ./.config

# 汉化 immortal主分支
# echo "CONFIG_PACKAGE_luci=y" >> ./.config
# echo "CONFIG_LUCI_LANG_zh_Hans=y" >> ./.config

CFG_FILE="./package/base-files/files/bin/config_generate"
# 修改默认主机名
sed -i "s/hostname='.*'/hostname='OpenWrt'/g" $CFG_FILE
# 修改默认时区
sed -i "s/timezone='.*'/timezone='CST-8'/g" $CFG_FILE
sed -i "/timezone='.*'/a\\\t\t\set system.@system[-1].zonename='Asia/Shanghai'" $CFG_FILE


# 修改默认WIFI名 Einstar
sed -i "s/ssid=.*/ssid=Einstar/g" ./package/kernel/mac80211/files/lib/wifi/mac80211.sh
# 修改默认WIFI名 适用于immortal主分支master
# sed -i "s/ssid=.*/ssid=Einstar/g" ./package/network/config/wifi-scripts/files/lib/wifi/mac80211.sh

# ddns-go软件 immortal自带 故注释
# git clone https://github.com/sirpdboy/luci-app-ddns-go.git package/ddns-go

# lucky AX3000T编译后无法启用 暂注释
# git clone  https://github.com/gdy666/luci-app-lucky.git package/lucky
# git clone https://github.com/sirpdboy/luci-app-lucky.git package/lucky


# tailscale
git clone https://github.com/asvow/luci-app-tailscale package/luci-app-tailscale

# iStore插件
echo 'src-git istore https://github.com/linkease/istore;main' >> feeds.conf.default

# pushbot插件 无法启动 先注释
# git clone https://github.com/zzsj0928/luci-app-pushbot package/luci-app-pushbot

# 修改默认主题 
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' ./feeds/luci/collections/luci/Makefile

# --------------- end ---------------

