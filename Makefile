#Makefile at top of application tree
TOP = .
include $(TOP)/configure/CONFIG
DIRS := $(DIRS) configure
DIRS := $(DIRS) prosilicaSupport
DIRS := $(DIRS) prosilicaApp
prosilicaApp_DEPEND_DIRS += prosilicaSupport
ifeq ($(BUILD_IOCS), YES)
DIRS := $(DIRS) $(filter-out $(DIRS), $(wildcard iocs))
iocs_DEPEND_DIRS += prosilicaApp
endif

include $(TOP)/configure/RULES_TOP

iocs:	iocs.install

iocs.build:	prosilicaApp.install
	$(MAKE) -C iocs build

iocs.install:	iocs.build prosilicaApp.install
	$(MAKE) -C iocs install

iocs.clean:
	$(MAKE) -C iocs clean

iocs.realclean:
	$(MAKE) -C iocs realuninstall

clean: iocs.clean

realclean realuninstall distclean: iocs.realclean

.PHONY: iocs iocs.build iocs.install iocs.realclean 
.PHONY: uninstall 
.PHONY: realuninstall 

