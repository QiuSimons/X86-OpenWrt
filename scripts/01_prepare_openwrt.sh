#!/bin/bash
latest_release="$(curl -s https://github.com/openwrt/openwrt/releases |grep -Eo "v[0-9\.]+.tar.gz" |sed -n 1p)"
curl -LO "https://github.com/openwrt/openwrt/archive/${latest_release}"
mkdir openwrt_back
shopt -s extglob 
tar zxvf ${latest_release}  --strip-components 1 -C ./openwrt_back
rm -f ./openwrt_back/feeds.conf.default
wget -P openwrt_back/ https://raw.githubusercontent.com/openwrt/openwrt/openwrt-19.07/feeds.conf.default
rm -f ${latest_release}
git clone --single-branch -b openwrt-19.07 https://github.com/openwrt/openwrt openwrt_new
rm -f ./openwrt_new/include/version.mk
rm -f ./openwrt_new/include/kernel-version.mk
rm -f ./openwrt_new/package/base-files/image-config.in
rm -rf ./openwrt_new/target/linux/.
cp -f ./openwrt_back/include/version.mk ./openwrt_new/include/version.mk
cp -f ./openwrt_back/include/kernel-version.mk ./openwrt_new/include/kernel-version.mk
cp -f ./openwrt_back/package/base-files/image-config.in ./openwrt_new/package/base-files/image-config.in
cp -rf ./openwrt_back/target/linux/. ./openwrt_new/target/linux/
cp -rf ./openwrt_new/. ./openwrt/
git clone -b 19.07 --single-branch https://github.com/Lienol/openwrt openwrt-lienol
exit 0
