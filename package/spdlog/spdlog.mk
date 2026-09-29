################################################################################
#
# spdlog
#
################################################################################

SPDLOG_VERSION = 1.17.0
SPDLOG_SITE = $(call github,gabime,spdlog,v$(SPDLOG_VERSION))
SPDLOG_LICENSE = MIT
SPDLOG_LICENSE_FILES = LICENSE
SPDLOG_INSTALL_STAGING = YES
SPDLOG_DEPENDENCIES = fmt
HOST_SPDLOG_DEPENDENCIES = host-pkgconf
HOST_SPDLOG_CONF_OPTS += -DSPDLOG_FMT_EXTERNAL=OFF
SPDLOG_CONF_OPTS += \
	-DSPDLOG_BUILD_TESTS=OFF \
	-DSPDLOG_BUILD_EXAMPLE=OFF \
	-DSPDLOG_BUILD_BENCH=OFF \
	-DSPDLOG_FMT_EXTERNAL=ON

define SPDLOG_INSTALL_CMAKE_CONFIG_UNDER_SHARE
	$(SED) 's|set(export_dest_dir "$${CMAKE_INSTALL_LIBDIR}/cmake/spdlog")|set(export_dest_dir "$${CMAKE_INSTALL_DATADIR}/cmake/spdlog")|' $(@D)/CMakeLists.txt
endef
SPDLOG_POST_PATCH_HOOKS += SPDLOG_INSTALL_CMAKE_CONFIG_UNDER_SHARE

ifeq ($(BR2_STATIC_LIBS),y)
SPDLOG_CONF_OPTS += -DSPDLOG_BUILD_SHARED=OFF
else
SPDLOG_CONF_OPTS += -DSPDLOG_BUILD_SHARED=ON
endif

$(eval $(cmake-package))
$(eval $(host-cmake-package))
