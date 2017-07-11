srcdir = /home/dev/javin/php/php-src/ext/gmsm
builddir = /home/dev/javin/php/php-src/ext/gmsm
top_srcdir = /home/dev/javin/php/php-src/ext/gmsm
top_builddir = /home/dev/javin/php/php-src/ext/gmsm
EGREP = /bin/grep -E
SED = /bin/sed
CONFIGURE_COMMAND = './configure'
CONFIGURE_OPTIONS =
SHLIB_SUFFIX_NAME = so
SHLIB_DL_SUFFIX_NAME = so
ZEND_EXT_TYPE = zend_extension
RE2C = exit 0;
AWK = gawk
shared_objects_gmsm = miracl/mrcore.lo miracl/mrarth0.lo miracl/mrarth1.lo miracl/mrarth2.lo miracl/mralloc.lo miracl/mrsmall.lo miracl/mrio1.lo miracl/mrio2.lo miracl/mrgcd.lo miracl/mrjack.lo miracl/mrxgcd.lo miracl/mrarth3.lo miracl/mrbits.lo miracl/mrrand.lo miracl/mrprime.lo miracl/mrcrt.lo miracl/mrscrt.lo miracl/mrmonty.lo miracl/mrpower.lo miracl/mrsroot.lo miracl/mrcurve.lo miracl/mrfast.lo miracl/mrshs.lo miracl/mrshs256.lo miracl/mrshs512.lo miracl/mrsha3.lo miracl/mrfpe.lo miracl/mraes.lo miracl/mrgcm.lo miracl/mrlucas.lo miracl/mrzzn2.lo miracl/mrzzn2b.lo miracl/mrzzn3.lo miracl/mrzzn4.lo miracl/mrecn2.lo miracl/mrstrong.lo miracl/mrbrick.lo miracl/mrebrick.lo miracl/mrec2m.lo miracl/mrgf2m.lo miracl/mrflash.lo miracl/mrfrnd.lo miracl/mrdouble.lo miracl/mrround.lo miracl/mrbuild.lo miracl/mrflsh1.lo miracl/mrpi.lo miracl/mrflsh2.lo miracl/mrflsh3.lo miracl/mrflsh4.lo miracl/mrmuldv.lo miracl/bmark.lo sm2/GMSM2.lo sm3/GMSM3.lo sm4/GMSM4.lo utils/BCD.lo gmsm.lo
PHP_PECL_EXTENSION = gmsm
PHP_MODULES = $(phplibdir)/gmsm.la
PHP_ZEND_EX =
all_targets = $(PHP_MODULES) $(PHP_ZEND_EX)
install_targets = install-modules install-headers
prefix = /apps/php
exec_prefix = $(prefix)
libdir = ${exec_prefix}/lib
prefix = /apps/php
phplibdir = /home/dev/javin/php/php-src/ext/gmsm/modules
phpincludedir = /apps/php/include/php
CC = cc
CFLAGS = -g -O2
CFLAGS_CLEAN = $(CFLAGS)
CPP = cc -E
CPPFLAGS = -DHAVE_CONFIG_H
CXX =
CXXFLAGS =
CXXFLAGS_CLEAN = $(CXXFLAGS)
EXTENSION_DIR = /apps/php/lib/php/extensions/no-debug-non-zts-20100525
PHP_EXECUTABLE = /apps/php/bin/php
EXTRA_LDFLAGS =
EXTRA_LIBS =
INCLUDES = -I/apps/php/include/php -I/apps/php/include/php/main -I/apps/php/include/php/TSRM -I/apps/php/include/php/Zend -I/apps/php/include/php/ext -I/apps/php/include/php/ext/date/lib
LFLAGS =
LDFLAGS =
SHARED_LIBTOOL =
LIBTOOL = $(SHELL) $(top_builddir)/libtool
SHELL = /bin/sh
INSTALL_HEADERS =
mkinstalldirs = $(top_srcdir)/build/shtool mkdir -p
INSTALL = $(top_srcdir)/build/shtool install -c
INSTALL_DATA = $(INSTALL) -m 644

DEFS = -DPHP_ATOM_INC -I$(top_builddir)/include -I$(top_builddir)/main -I$(top_srcdir)
COMMON_FLAGS = $(DEFS) $(INCLUDES) $(EXTRA_INCLUDES) $(CPPFLAGS) $(PHP_FRAMEWORKPATH)

all: $(all_targets) 
	@echo
	@echo "Build complete."
	@echo "Don't forget to run 'make test'."
	@echo

build-modules: $(PHP_MODULES) $(PHP_ZEND_EX)

build-binaries: $(PHP_BINARIES)

libphp$(PHP_MAJOR_VERSION).la: $(PHP_GLOBAL_OBJS) $(PHP_SAPI_OBJS)
	$(LIBTOOL) --mode=link $(CC) $(CFLAGS) $(EXTRA_CFLAGS) -rpath $(phptempdir) $(EXTRA_LDFLAGS) $(LDFLAGS) $(PHP_RPATHS) $(PHP_GLOBAL_OBJS) $(PHP_SAPI_OBJS) $(EXTRA_LIBS) $(ZEND_EXTRA_LIBS) -o $@
	-@$(LIBTOOL) --silent --mode=install cp $@ $(phptempdir)/$@ >/dev/null 2>&1

libs/libphp$(PHP_MAJOR_VERSION).bundle: $(PHP_GLOBAL_OBJS) $(PHP_SAPI_OBJS)
	$(CC) $(MH_BUNDLE_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS) $(LDFLAGS) $(EXTRA_LDFLAGS) $(PHP_GLOBAL_OBJS:.lo=.o) $(PHP_SAPI_OBJS:.lo=.o) $(PHP_FRAMEWORKS) $(EXTRA_LIBS) $(ZEND_EXTRA_LIBS) -o $@ && cp $@ libs/libphp$(PHP_MAJOR_VERSION).so

install: $(all_targets) $(install_targets)

install-sapi: $(OVERALL_TARGET)
	@echo "Installing PHP SAPI module:       $(PHP_SAPI)"
	-@$(mkinstalldirs) $(INSTALL_ROOT)$(bindir)
	-@if test ! -r $(phptempdir)/libphp$(PHP_MAJOR_VERSION).$(SHLIB_DL_SUFFIX_NAME); then \
		for i in 0.0.0 0.0 0; do \
			if test -r $(phptempdir)/libphp$(PHP_MAJOR_VERSION).$(SHLIB_DL_SUFFIX_NAME).$$i; then \
				$(LN_S) $(phptempdir)/libphp$(PHP_MAJOR_VERSION).$(SHLIB_DL_SUFFIX_NAME).$$i $(phptempdir)/libphp$(PHP_MAJOR_VERSION).$(SHLIB_DL_SUFFIX_NAME); \
				break; \
			fi; \
		done; \
	fi
	@$(INSTALL_IT)

install-binaries: build-binaries $(install_binary_targets)

install-modules: build-modules
	@test -d modules && \
	$(mkinstalldirs) $(INSTALL_ROOT)$(EXTENSION_DIR)
	@echo "Installing shared extensions:     $(INSTALL_ROOT)$(EXTENSION_DIR)/"
	@rm -f modules/*.la >/dev/null 2>&1
	@$(INSTALL) modules/* $(INSTALL_ROOT)$(EXTENSION_DIR)

install-headers:
	-@if test "$(INSTALL_HEADERS)"; then \
		for i in `echo $(INSTALL_HEADERS)`; do \
			i=`$(top_srcdir)/build/shtool path -d $$i`; \
			paths="$$paths $(INSTALL_ROOT)$(phpincludedir)/$$i"; \
		done; \
		$(mkinstalldirs) $$paths && \
		echo "Installing header files:          $(INSTALL_ROOT)$(phpincludedir)/" && \
		for i in `echo $(INSTALL_HEADERS)`; do \
			if test "$(PHP_PECL_EXTENSION)"; then \
				src=`echo $$i | $(SED) -e "s#ext/$(PHP_PECL_EXTENSION)/##g"`; \
			else \
				src=$$i; \
			fi; \
			if test -f "$(top_srcdir)/$$src"; then \
				$(INSTALL_DATA) $(top_srcdir)/$$src $(INSTALL_ROOT)$(phpincludedir)/$$i; \
			elif test -f "$(top_builddir)/$$src"; then \
				$(INSTALL_DATA) $(top_builddir)/$$src $(INSTALL_ROOT)$(phpincludedir)/$$i; \
			else \
				(cd $(top_srcdir)/$$src && $(INSTALL_DATA) *.h $(INSTALL_ROOT)$(phpincludedir)/$$i; \
				cd $(top_builddir)/$$src && $(INSTALL_DATA) *.h $(INSTALL_ROOT)$(phpincludedir)/$$i) 2>/dev/null || true; \
			fi \
		done; \
	fi

PHP_TEST_SETTINGS = -d 'open_basedir=' -d 'output_buffering=0' -d 'memory_limit=-1'
PHP_TEST_SHARED_EXTENSIONS =  ` \
	if test "x$(PHP_MODULES)" != "x"; then \
		for i in $(PHP_MODULES)""; do \
			. $$i; $(top_srcdir)/build/shtool echo -n -- " -d extension=$$dlname"; \
		done; \
	fi; \
	if test "x$(PHP_ZEND_EX)" != "x"; then \
		for i in $(PHP_ZEND_EX)""; do \
			. $$i; $(top_srcdir)/build/shtool echo -n -- " -d $(ZEND_EXT_TYPE)=$(top_builddir)/modules/$$dlname"; \
		done; \
	fi`
PHP_DEPRECATED_DIRECTIVES_REGEX = '^(magic_quotes_(gpc|runtime|sybase)?|(zend_)?extension(_debug)?(_ts)?)[\t\ ]*='

test: all
	-@if test ! -z "$(PHP_EXECUTABLE)" && test -x "$(PHP_EXECUTABLE)"; then \
		INI_FILE=`$(PHP_EXECUTABLE) -d 'display_errors=stderr' -r 'echo php_ini_loaded_file();' 2> /dev/null`; \
		if test "$$INI_FILE"; then \
			$(EGREP) -h -v $(PHP_DEPRECATED_DIRECTIVES_REGEX) "$$INI_FILE" > $(top_builddir)/tmp-php.ini; \
		else \
			echo > $(top_builddir)/tmp-php.ini; \
		fi; \
		INI_SCANNED_PATH=`$(PHP_EXECUTABLE) -d 'display_errors=stderr' -r '$$a = explode(",\n", trim(php_ini_scanned_files())); echo $$a[0];' 2> /dev/null`; \
		if test "$$INI_SCANNED_PATH"; then \
			INI_SCANNED_PATH=`$(top_srcdir)/build/shtool path -d $$INI_SCANNED_PATH`; \
			$(EGREP) -h -v $(PHP_DEPRECATED_DIRECTIVES_REGEX) "$$INI_SCANNED_PATH"/*.ini >> $(top_builddir)/tmp-php.ini; \
		fi; \
		TEST_PHP_EXECUTABLE=$(PHP_EXECUTABLE) \
		TEST_PHP_SRCDIR=$(top_srcdir) \
		CC="$(CC)" \
			$(PHP_EXECUTABLE) -n -c $(top_builddir)/tmp-php.ini $(PHP_TEST_SETTINGS) $(top_srcdir)/run-tests.php -n -c $(top_builddir)/tmp-php.ini -d extension_dir=$(top_builddir)/modules/ $(PHP_TEST_SHARED_EXTENSIONS) $(TESTS); \
		rm $(top_builddir)/tmp-php.ini; \
	else \
		echo "ERROR: Cannot run tests without CLI sapi."; \
	fi

clean:
	find . -name \*.gcno -o -name \*.gcda | xargs rm -f
	find . -name \*.lo -o -name \*.o | xargs rm -f
	find . -name \*.la -o -name \*.a | xargs rm -f 
	find . -name \*.so | xargs rm -f
	find . -name .libs -a -type d|xargs rm -rf
	find . -name \*.1 | xargs rm -f
	rm -f libphp$(PHP_MAJOR_VERSION).la $(SAPI_CLI_PATH) $(OVERALL_TARGET) modules/* libs/*

distclean: clean
	rm -f Makefile config.cache config.log config.status Makefile.objects Makefile.fragments libtool main/php_config.h stamp-h sapi/apache/libphp$(PHP_MAJOR_VERSION).module buildmk.stamp Zend/zend_dtrace_gen.h Zend/zend_dtrace_gen.h.bak
	$(EGREP) define'.*include/php' $(top_srcdir)/configure | $(SED) 's/.*>//'|xargs rm -f

.PHONY: all clean install distclean test
.NOEXPORT:
miracl/mrcore.lo: /home/dev/javin/php/php-src/ext/gmsm/miracl/mrcore.c
	$(LIBTOOL) --mode=compile $(CC)  -I. -I/home/dev/javin/php/php-src/ext/gmsm $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/dev/javin/php/php-src/ext/gmsm/miracl/mrcore.c -o miracl/mrcore.lo 
miracl/mrarth0.lo: /home/dev/javin/php/php-src/ext/gmsm/miracl/mrarth0.c
	$(LIBTOOL) --mode=compile $(CC)  -I. -I/home/dev/javin/php/php-src/ext/gmsm $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/dev/javin/php/php-src/ext/gmsm/miracl/mrarth0.c -o miracl/mrarth0.lo 
miracl/mrarth1.lo: /home/dev/javin/php/php-src/ext/gmsm/miracl/mrarth1.c
	$(LIBTOOL) --mode=compile $(CC)  -I. -I/home/dev/javin/php/php-src/ext/gmsm $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/dev/javin/php/php-src/ext/gmsm/miracl/mrarth1.c -o miracl/mrarth1.lo 
miracl/mrarth2.lo: /home/dev/javin/php/php-src/ext/gmsm/miracl/mrarth2.c
	$(LIBTOOL) --mode=compile $(CC)  -I. -I/home/dev/javin/php/php-src/ext/gmsm $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/dev/javin/php/php-src/ext/gmsm/miracl/mrarth2.c -o miracl/mrarth2.lo 
miracl/mralloc.lo: /home/dev/javin/php/php-src/ext/gmsm/miracl/mralloc.c
	$(LIBTOOL) --mode=compile $(CC)  -I. -I/home/dev/javin/php/php-src/ext/gmsm $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/dev/javin/php/php-src/ext/gmsm/miracl/mralloc.c -o miracl/mralloc.lo 
miracl/mrsmall.lo: /home/dev/javin/php/php-src/ext/gmsm/miracl/mrsmall.c
	$(LIBTOOL) --mode=compile $(CC)  -I. -I/home/dev/javin/php/php-src/ext/gmsm $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/dev/javin/php/php-src/ext/gmsm/miracl/mrsmall.c -o miracl/mrsmall.lo 
miracl/mrio1.lo: /home/dev/javin/php/php-src/ext/gmsm/miracl/mrio1.c
	$(LIBTOOL) --mode=compile $(CC)  -I. -I/home/dev/javin/php/php-src/ext/gmsm $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/dev/javin/php/php-src/ext/gmsm/miracl/mrio1.c -o miracl/mrio1.lo 
miracl/mrio2.lo: /home/dev/javin/php/php-src/ext/gmsm/miracl/mrio2.c
	$(LIBTOOL) --mode=compile $(CC)  -I. -I/home/dev/javin/php/php-src/ext/gmsm $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/dev/javin/php/php-src/ext/gmsm/miracl/mrio2.c -o miracl/mrio2.lo 
miracl/mrgcd.lo: /home/dev/javin/php/php-src/ext/gmsm/miracl/mrgcd.c
	$(LIBTOOL) --mode=compile $(CC)  -I. -I/home/dev/javin/php/php-src/ext/gmsm $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/dev/javin/php/php-src/ext/gmsm/miracl/mrgcd.c -o miracl/mrgcd.lo 
miracl/mrjack.lo: /home/dev/javin/php/php-src/ext/gmsm/miracl/mrjack.c
	$(LIBTOOL) --mode=compile $(CC)  -I. -I/home/dev/javin/php/php-src/ext/gmsm $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/dev/javin/php/php-src/ext/gmsm/miracl/mrjack.c -o miracl/mrjack.lo 
miracl/mrxgcd.lo: /home/dev/javin/php/php-src/ext/gmsm/miracl/mrxgcd.c
	$(LIBTOOL) --mode=compile $(CC)  -I. -I/home/dev/javin/php/php-src/ext/gmsm $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/dev/javin/php/php-src/ext/gmsm/miracl/mrxgcd.c -o miracl/mrxgcd.lo 
miracl/mrarth3.lo: /home/dev/javin/php/php-src/ext/gmsm/miracl/mrarth3.c
	$(LIBTOOL) --mode=compile $(CC)  -I. -I/home/dev/javin/php/php-src/ext/gmsm $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/dev/javin/php/php-src/ext/gmsm/miracl/mrarth3.c -o miracl/mrarth3.lo 
miracl/mrbits.lo: /home/dev/javin/php/php-src/ext/gmsm/miracl/mrbits.c
	$(LIBTOOL) --mode=compile $(CC)  -I. -I/home/dev/javin/php/php-src/ext/gmsm $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/dev/javin/php/php-src/ext/gmsm/miracl/mrbits.c -o miracl/mrbits.lo 
miracl/mrrand.lo: /home/dev/javin/php/php-src/ext/gmsm/miracl/mrrand.c
	$(LIBTOOL) --mode=compile $(CC)  -I. -I/home/dev/javin/php/php-src/ext/gmsm $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/dev/javin/php/php-src/ext/gmsm/miracl/mrrand.c -o miracl/mrrand.lo 
miracl/mrprime.lo: /home/dev/javin/php/php-src/ext/gmsm/miracl/mrprime.c
	$(LIBTOOL) --mode=compile $(CC)  -I. -I/home/dev/javin/php/php-src/ext/gmsm $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/dev/javin/php/php-src/ext/gmsm/miracl/mrprime.c -o miracl/mrprime.lo 
miracl/mrcrt.lo: /home/dev/javin/php/php-src/ext/gmsm/miracl/mrcrt.c
	$(LIBTOOL) --mode=compile $(CC)  -I. -I/home/dev/javin/php/php-src/ext/gmsm $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/dev/javin/php/php-src/ext/gmsm/miracl/mrcrt.c -o miracl/mrcrt.lo 
miracl/mrscrt.lo: /home/dev/javin/php/php-src/ext/gmsm/miracl/mrscrt.c
	$(LIBTOOL) --mode=compile $(CC)  -I. -I/home/dev/javin/php/php-src/ext/gmsm $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/dev/javin/php/php-src/ext/gmsm/miracl/mrscrt.c -o miracl/mrscrt.lo 
miracl/mrmonty.lo: /home/dev/javin/php/php-src/ext/gmsm/miracl/mrmonty.c
	$(LIBTOOL) --mode=compile $(CC)  -I. -I/home/dev/javin/php/php-src/ext/gmsm $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/dev/javin/php/php-src/ext/gmsm/miracl/mrmonty.c -o miracl/mrmonty.lo 
miracl/mrpower.lo: /home/dev/javin/php/php-src/ext/gmsm/miracl/mrpower.c
	$(LIBTOOL) --mode=compile $(CC)  -I. -I/home/dev/javin/php/php-src/ext/gmsm $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/dev/javin/php/php-src/ext/gmsm/miracl/mrpower.c -o miracl/mrpower.lo 
miracl/mrsroot.lo: /home/dev/javin/php/php-src/ext/gmsm/miracl/mrsroot.c
	$(LIBTOOL) --mode=compile $(CC)  -I. -I/home/dev/javin/php/php-src/ext/gmsm $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/dev/javin/php/php-src/ext/gmsm/miracl/mrsroot.c -o miracl/mrsroot.lo 
miracl/mrcurve.lo: /home/dev/javin/php/php-src/ext/gmsm/miracl/mrcurve.c
	$(LIBTOOL) --mode=compile $(CC)  -I. -I/home/dev/javin/php/php-src/ext/gmsm $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/dev/javin/php/php-src/ext/gmsm/miracl/mrcurve.c -o miracl/mrcurve.lo 
miracl/mrfast.lo: /home/dev/javin/php/php-src/ext/gmsm/miracl/mrfast.c
	$(LIBTOOL) --mode=compile $(CC)  -I. -I/home/dev/javin/php/php-src/ext/gmsm $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/dev/javin/php/php-src/ext/gmsm/miracl/mrfast.c -o miracl/mrfast.lo 
miracl/mrshs.lo: /home/dev/javin/php/php-src/ext/gmsm/miracl/mrshs.c
	$(LIBTOOL) --mode=compile $(CC)  -I. -I/home/dev/javin/php/php-src/ext/gmsm $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/dev/javin/php/php-src/ext/gmsm/miracl/mrshs.c -o miracl/mrshs.lo 
miracl/mrshs256.lo: /home/dev/javin/php/php-src/ext/gmsm/miracl/mrshs256.c
	$(LIBTOOL) --mode=compile $(CC)  -I. -I/home/dev/javin/php/php-src/ext/gmsm $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/dev/javin/php/php-src/ext/gmsm/miracl/mrshs256.c -o miracl/mrshs256.lo 
miracl/mrshs512.lo: /home/dev/javin/php/php-src/ext/gmsm/miracl/mrshs512.c
	$(LIBTOOL) --mode=compile $(CC)  -I. -I/home/dev/javin/php/php-src/ext/gmsm $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/dev/javin/php/php-src/ext/gmsm/miracl/mrshs512.c -o miracl/mrshs512.lo 
miracl/mrsha3.lo: /home/dev/javin/php/php-src/ext/gmsm/miracl/mrsha3.c
	$(LIBTOOL) --mode=compile $(CC)  -I. -I/home/dev/javin/php/php-src/ext/gmsm $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/dev/javin/php/php-src/ext/gmsm/miracl/mrsha3.c -o miracl/mrsha3.lo 
miracl/mrfpe.lo: /home/dev/javin/php/php-src/ext/gmsm/miracl/mrfpe.c
	$(LIBTOOL) --mode=compile $(CC)  -I. -I/home/dev/javin/php/php-src/ext/gmsm $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/dev/javin/php/php-src/ext/gmsm/miracl/mrfpe.c -o miracl/mrfpe.lo 
miracl/mraes.lo: /home/dev/javin/php/php-src/ext/gmsm/miracl/mraes.c
	$(LIBTOOL) --mode=compile $(CC)  -I. -I/home/dev/javin/php/php-src/ext/gmsm $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/dev/javin/php/php-src/ext/gmsm/miracl/mraes.c -o miracl/mraes.lo 
miracl/mrgcm.lo: /home/dev/javin/php/php-src/ext/gmsm/miracl/mrgcm.c
	$(LIBTOOL) --mode=compile $(CC)  -I. -I/home/dev/javin/php/php-src/ext/gmsm $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/dev/javin/php/php-src/ext/gmsm/miracl/mrgcm.c -o miracl/mrgcm.lo 
miracl/mrlucas.lo: /home/dev/javin/php/php-src/ext/gmsm/miracl/mrlucas.c
	$(LIBTOOL) --mode=compile $(CC)  -I. -I/home/dev/javin/php/php-src/ext/gmsm $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/dev/javin/php/php-src/ext/gmsm/miracl/mrlucas.c -o miracl/mrlucas.lo 
miracl/mrzzn2.lo: /home/dev/javin/php/php-src/ext/gmsm/miracl/mrzzn2.c
	$(LIBTOOL) --mode=compile $(CC)  -I. -I/home/dev/javin/php/php-src/ext/gmsm $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/dev/javin/php/php-src/ext/gmsm/miracl/mrzzn2.c -o miracl/mrzzn2.lo 
miracl/mrzzn2b.lo: /home/dev/javin/php/php-src/ext/gmsm/miracl/mrzzn2b.c
	$(LIBTOOL) --mode=compile $(CC)  -I. -I/home/dev/javin/php/php-src/ext/gmsm $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/dev/javin/php/php-src/ext/gmsm/miracl/mrzzn2b.c -o miracl/mrzzn2b.lo 
miracl/mrzzn3.lo: /home/dev/javin/php/php-src/ext/gmsm/miracl/mrzzn3.c
	$(LIBTOOL) --mode=compile $(CC)  -I. -I/home/dev/javin/php/php-src/ext/gmsm $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/dev/javin/php/php-src/ext/gmsm/miracl/mrzzn3.c -o miracl/mrzzn3.lo 
miracl/mrzzn4.lo: /home/dev/javin/php/php-src/ext/gmsm/miracl/mrzzn4.c
	$(LIBTOOL) --mode=compile $(CC)  -I. -I/home/dev/javin/php/php-src/ext/gmsm $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/dev/javin/php/php-src/ext/gmsm/miracl/mrzzn4.c -o miracl/mrzzn4.lo 
miracl/mrecn2.lo: /home/dev/javin/php/php-src/ext/gmsm/miracl/mrecn2.c
	$(LIBTOOL) --mode=compile $(CC)  -I. -I/home/dev/javin/php/php-src/ext/gmsm $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/dev/javin/php/php-src/ext/gmsm/miracl/mrecn2.c -o miracl/mrecn2.lo 
miracl/mrstrong.lo: /home/dev/javin/php/php-src/ext/gmsm/miracl/mrstrong.c
	$(LIBTOOL) --mode=compile $(CC)  -I. -I/home/dev/javin/php/php-src/ext/gmsm $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/dev/javin/php/php-src/ext/gmsm/miracl/mrstrong.c -o miracl/mrstrong.lo 
miracl/mrbrick.lo: /home/dev/javin/php/php-src/ext/gmsm/miracl/mrbrick.c
	$(LIBTOOL) --mode=compile $(CC)  -I. -I/home/dev/javin/php/php-src/ext/gmsm $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/dev/javin/php/php-src/ext/gmsm/miracl/mrbrick.c -o miracl/mrbrick.lo 
miracl/mrebrick.lo: /home/dev/javin/php/php-src/ext/gmsm/miracl/mrebrick.c
	$(LIBTOOL) --mode=compile $(CC)  -I. -I/home/dev/javin/php/php-src/ext/gmsm $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/dev/javin/php/php-src/ext/gmsm/miracl/mrebrick.c -o miracl/mrebrick.lo 
miracl/mrec2m.lo: /home/dev/javin/php/php-src/ext/gmsm/miracl/mrec2m.c
	$(LIBTOOL) --mode=compile $(CC)  -I. -I/home/dev/javin/php/php-src/ext/gmsm $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/dev/javin/php/php-src/ext/gmsm/miracl/mrec2m.c -o miracl/mrec2m.lo 
miracl/mrgf2m.lo: /home/dev/javin/php/php-src/ext/gmsm/miracl/mrgf2m.c
	$(LIBTOOL) --mode=compile $(CC)  -I. -I/home/dev/javin/php/php-src/ext/gmsm $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/dev/javin/php/php-src/ext/gmsm/miracl/mrgf2m.c -o miracl/mrgf2m.lo 
miracl/mrflash.lo: /home/dev/javin/php/php-src/ext/gmsm/miracl/mrflash.c
	$(LIBTOOL) --mode=compile $(CC)  -I. -I/home/dev/javin/php/php-src/ext/gmsm $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/dev/javin/php/php-src/ext/gmsm/miracl/mrflash.c -o miracl/mrflash.lo 
miracl/mrfrnd.lo: /home/dev/javin/php/php-src/ext/gmsm/miracl/mrfrnd.c
	$(LIBTOOL) --mode=compile $(CC)  -I. -I/home/dev/javin/php/php-src/ext/gmsm $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/dev/javin/php/php-src/ext/gmsm/miracl/mrfrnd.c -o miracl/mrfrnd.lo 
miracl/mrdouble.lo: /home/dev/javin/php/php-src/ext/gmsm/miracl/mrdouble.c
	$(LIBTOOL) --mode=compile $(CC)  -I. -I/home/dev/javin/php/php-src/ext/gmsm $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/dev/javin/php/php-src/ext/gmsm/miracl/mrdouble.c -o miracl/mrdouble.lo 
miracl/mrround.lo: /home/dev/javin/php/php-src/ext/gmsm/miracl/mrround.c
	$(LIBTOOL) --mode=compile $(CC)  -I. -I/home/dev/javin/php/php-src/ext/gmsm $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/dev/javin/php/php-src/ext/gmsm/miracl/mrround.c -o miracl/mrround.lo 
miracl/mrbuild.lo: /home/dev/javin/php/php-src/ext/gmsm/miracl/mrbuild.c
	$(LIBTOOL) --mode=compile $(CC)  -I. -I/home/dev/javin/php/php-src/ext/gmsm $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/dev/javin/php/php-src/ext/gmsm/miracl/mrbuild.c -o miracl/mrbuild.lo 
miracl/mrflsh1.lo: /home/dev/javin/php/php-src/ext/gmsm/miracl/mrflsh1.c
	$(LIBTOOL) --mode=compile $(CC)  -I. -I/home/dev/javin/php/php-src/ext/gmsm $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/dev/javin/php/php-src/ext/gmsm/miracl/mrflsh1.c -o miracl/mrflsh1.lo 
miracl/mrpi.lo: /home/dev/javin/php/php-src/ext/gmsm/miracl/mrpi.c
	$(LIBTOOL) --mode=compile $(CC)  -I. -I/home/dev/javin/php/php-src/ext/gmsm $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/dev/javin/php/php-src/ext/gmsm/miracl/mrpi.c -o miracl/mrpi.lo 
miracl/mrflsh2.lo: /home/dev/javin/php/php-src/ext/gmsm/miracl/mrflsh2.c
	$(LIBTOOL) --mode=compile $(CC)  -I. -I/home/dev/javin/php/php-src/ext/gmsm $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/dev/javin/php/php-src/ext/gmsm/miracl/mrflsh2.c -o miracl/mrflsh2.lo 
miracl/mrflsh3.lo: /home/dev/javin/php/php-src/ext/gmsm/miracl/mrflsh3.c
	$(LIBTOOL) --mode=compile $(CC)  -I. -I/home/dev/javin/php/php-src/ext/gmsm $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/dev/javin/php/php-src/ext/gmsm/miracl/mrflsh3.c -o miracl/mrflsh3.lo 
miracl/mrflsh4.lo: /home/dev/javin/php/php-src/ext/gmsm/miracl/mrflsh4.c
	$(LIBTOOL) --mode=compile $(CC)  -I. -I/home/dev/javin/php/php-src/ext/gmsm $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/dev/javin/php/php-src/ext/gmsm/miracl/mrflsh4.c -o miracl/mrflsh4.lo 
miracl/mrmuldv.lo: /home/dev/javin/php/php-src/ext/gmsm/miracl/mrmuldv.c
	$(LIBTOOL) --mode=compile $(CC)  -I. -I/home/dev/javin/php/php-src/ext/gmsm $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/dev/javin/php/php-src/ext/gmsm/miracl/mrmuldv.c -o miracl/mrmuldv.lo 
miracl/bmark.lo: /home/dev/javin/php/php-src/ext/gmsm/miracl/bmark.c
	$(LIBTOOL) --mode=compile $(CC)  -I. -I/home/dev/javin/php/php-src/ext/gmsm $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/dev/javin/php/php-src/ext/gmsm/miracl/bmark.c -o miracl/bmark.lo 
sm2/GMSM2.lo: /home/dev/javin/php/php-src/ext/gmsm/sm2/GMSM2.c
	$(LIBTOOL) --mode=compile $(CC)  -I. -I/home/dev/javin/php/php-src/ext/gmsm $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/dev/javin/php/php-src/ext/gmsm/sm2/GMSM2.c -o sm2/GMSM2.lo 
sm3/GMSM3.lo: /home/dev/javin/php/php-src/ext/gmsm/sm3/GMSM3.c
	$(LIBTOOL) --mode=compile $(CC)  -I. -I/home/dev/javin/php/php-src/ext/gmsm $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/dev/javin/php/php-src/ext/gmsm/sm3/GMSM3.c -o sm3/GMSM3.lo 
sm4/GMSM4.lo: /home/dev/javin/php/php-src/ext/gmsm/sm4/GMSM4.c
	$(LIBTOOL) --mode=compile $(CC)  -I. -I/home/dev/javin/php/php-src/ext/gmsm $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/dev/javin/php/php-src/ext/gmsm/sm4/GMSM4.c -o sm4/GMSM4.lo 
utils/BCD.lo: /home/dev/javin/php/php-src/ext/gmsm/utils/BCD.c
	$(LIBTOOL) --mode=compile $(CC)  -I. -I/home/dev/javin/php/php-src/ext/gmsm $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/dev/javin/php/php-src/ext/gmsm/utils/BCD.c -o utils/BCD.lo 
gmsm.lo: /home/dev/javin/php/php-src/ext/gmsm/gmsm.c
	$(LIBTOOL) --mode=compile $(CC)  -I. -I/home/dev/javin/php/php-src/ext/gmsm $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/dev/javin/php/php-src/ext/gmsm/gmsm.c -o gmsm.lo 
$(phplibdir)/gmsm.la: ./gmsm.la
	$(LIBTOOL) --mode=install cp ./gmsm.la $(phplibdir)

./gmsm.la: $(shared_objects_gmsm) $(GMSM_SHARED_DEPENDENCIES)
	$(LIBTOOL) --mode=link $(CC) $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS) $(LDFLAGS) -o $@ -export-dynamic -avoid-version -prefer-pic -module -rpath $(phplibdir) $(EXTRA_LDFLAGS) $(shared_objects_gmsm) $(GMSM_SHARED_LIBADD)

