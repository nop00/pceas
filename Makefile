BIN     := pceas

CC      := gcc
ECHO    := echo
RM      := rm
CD      := cd
TAR     := tar

BUILD_DIR := build

OUTDIR  := $(BUILD_DIR)
CFLAGS  := -W -Wall

USE_CLANG ?= 0
ifeq ($(USE_CLANG), 1)
    CC := clang
endif

DEBUG   ?= 0
ifeq ($(DEBUG), 1)
	OUTDIR := $(OUTDIR)/Debug
	CFLAGS += -g -DDEBUG
else
	OUTDIR := $(OUTDIR)/Release
	CFLAGS += -O2
endif
OBJDIR := $(OUTDIR)/obj

LIBS   :=  -lm

EXE_SRC := $(wildcard *.c)
OBJS    := $(EXE_SRC:.c=.o)
EXE_OBJ := $(addprefix $(OBJDIR)/, $(OBJS))
EXE     := $(OUTDIR)/$(BIN)

DEPEND = .depend

all: $(EXE)

dep: $(DEPEND)

$(DEPEND):
	@$(ECHO) "  MKDEP"
	@$(CC) -MM -MG $(CFLAGS) $(EXE_SRC) > $(DEPEND)

$(EXE): $(EXE_OBJ)
	@$(ECHO) "  LD        $@"
	@$(CC) -o $(EXE) $^ $(LIBS)

$(OBJDIR)/%.o: %.c
	@$(ECHO) "  CC        $@"
	@$(CC) $(CFLAGS) -c -o $@ $<

$(EXE_OBJ): | $(OBJDIR) $(OUTDIR)

$(OUTDIR):
	@mkdir  -p $(OUTDIR)

$(OBJDIR):
	@mkdir  -p $(OBJDIR)

install:

clean: FORCE
	@$(ECHO) "  CLEAN     object files"
	@find $(BUILD_DIR) -name "*.o" -exec $(RM) -f {} \;

realclean: clean
	@$(ECHO) "  CLEAN     $(EXE)"
	@$(RM) -f $(EXE)
	@$(ECHO) "  CLEAN     noise files"
	@$(RM) -f `find . -name "*~" -o -name "\#*"`

c: clean

rc: realclean

archive: realclean
	@$(ECHO) "  TBZ2      `date +"%Y/%m/%d"`"
	@$(CD) ..; $(TAR) jcf etripator-`date +"%Y%m%d"`.tar.bz2 same

FORCE :
ifeq (.depend,$(wildcard .depend))
include .depend
endif
