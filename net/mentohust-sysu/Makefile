#
# Copyright (C) 2017 Icenowy Zheng
# Based on work that is Copyright (C) 2006-2011 Xmlad.com
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=mentohust-sysu
PKG_VERSION:=0.1

PKG_SOURCE:=sysu-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/sysu-linux-proj/mentohust-SYSU/archive/
PKG_SOURCE_SUBDIR:=mentohust-SYSU-sysu-$(PKG_VERSION)
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_SOURCE_SUBDIR)
PKG_MD5SUM:=48ca34b495bccabac86cb6d6d7460ba6

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/mentohust-sysu
	SECTION:=net
	CATEGORY:=Network
	DEPENDS:=+libpcap
	TITLE:=SYSU South/North/Zhuhai Campus RuiJie client
	URL:=https://github.com/sysu-linux-proj/mentohust-SYSU
	SUBMENU:=Sun-Yat-Sen University
endef

define Package/mentohust-sysu/description
A RuiJie client for SYSU South/North/Zhuhai Campus.
endef

define Build/Prepare
	$(call Build/Prepare/Default)
	pushd $(PKG_BUILD_DIR) && autoreconf -fi && popd
	$(SED) 's/dhclient/udhcpc -i/g' $(PKG_BUILD_DIR)/src/myconfig.c
endef

CONFIGURE_ARGS += \
	--disable-encodepass \
	--disable-notify

# XXX: CFLAGS are already set by Build/Compile/Default
MAKE_FLAGS+= \
	OFLAGS=""

define Package/mentohust-sysu/conffiles
/etc/mentohust.conf
endef

define Package/mentohust-sysu/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/mentohust $(1)/usr/sbin/
	chmod 755 $(1)/usr/sbin/
	$(INSTALL_DIR) $(1)/etc
	$(INSTALL_CONF) $(PKG_INSTALL_DIR)/etc/mentohust.conf $(1)/etc/
endef

$(eval $(call BuildPackage,mentohust-sysu))
