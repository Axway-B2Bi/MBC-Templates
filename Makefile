MODULE_NAME = MBC_templates

MB_INCLUDE  = $(CORE_SOLUTIONS)/4edi/include:$(CORE_ROOT)/4edi/include
MB_LIB      = $(CORE_SOLUTIONS)/4edi/lib:$(CORE_ROOT)/4edi/lib

MDEP_C4EDI = $(CORE_ROOT)/bin/c4edi
MDEP_R4EDI = $(CORE_ROOT)/bin/r4edi

INCLUDE = 	\
    -I src/4edi/include \
    -I $(MB_INCLUDE)

LIBRARIES = \
    -L src/4edi/lib \
    -L $(MB_LIB)

MB_FLAGS = -T -P nopathtrace

TARGETS = \
	procmbc_template_creator.x4          \
	procmbc_template_modifier.x4         \
	procmbc_template_creator2.x4          

compile: $(TARGETS)

procmbc_template_creator.x4  : \
	procmbc_template_creator.s4
	$(MDEP_C4EDI)  $(MB_FLAGS)  \
	$(INCLUDE)                  \
    $(LIBRARIES)              \
	-o $@                       \
	procmbc_template_creator.s4

procmbc_template_creator2.x4  : \
	procmbc_template_creator2.s4
	$(MDEP_C4EDI)  $(MB_FLAGS)  \
	$(INCLUDE)                  \
    $(LIBRARIES)              \
	-o $@                       \
	procmbc_template_creator2.s4

procmbc_template_modifier.x4  : \
	procmbc_template_modifier.s4
	$(MDEP_C4EDI)  $(MB_FLAGS)  \
	$(INCLUDE)                  \
    $(LIBRARIES)              \
	-o $@                       \
	procmbc_template_modifier.s4

distr:
	mkdir $@
	cp procmbc_template_modifier.s4          $@
	cp procmbc_template_creator.s4           $@
	cp procmbc_template_creator2.s4          $@
	(cd distr ; tar -cf - . | gzip) > $(MODULE_NAME).tgz
	rm -rf distr

clean:
	rm $(TARGETS)


