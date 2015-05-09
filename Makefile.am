# whitakerswords - Christopher Fair

SUBDIRS = src

EXTRA_DIST = ada.m4  confvars.ads.frame.in


# ======================================================================
# Make time Date.

# ISO flavor.
MAKEDATEISO=`${DATE} +%Y-%m-%d`
#Redhat Package Manager flavor.
MAKEDATERPM=`${DATE} "+%a %b %d %Y"`

# ==================================================
# Let's get pickier about cleaning up.

# Specific files. -----------------------
  MOSTLYCLEANFILES = core
  CLEANFILES       = confvars.ads.frame.in confvars.ads.frame confvars.ads
#  DISTCLEANFILES   =

# Specific patterns. --------------------

mostlyclean-local:
	-rm -f *.swp *~ .*~ # Old vi backup files.

clean-local: mostlyclean-local
	-rm -f *.ali *.o *.rpm *.tar *.gz *.zip *.bz *.bz2 *.Z *.z # Things I build and don't tell make about

distclean-local: clean-local
	-rm -R -f -v autom4te.cache # I don't know why distclean doesn't do these.

# really clean this out.
zapeverything: distclean
	@echo ""
	@echo "*** Removing files critical to make/configure process"
	@echo "*** You'll have to redo aclocal;automake --add-missing;autoconf;"
	@echo "***  before you do another make"
	@echo ""
	-rm -f configure Makefile config.h.in config.guess config.sub depcomp
	-rm -f INSTALL # But not COPYING, since I've probably updated that.
	-rm -f aclocal.m4

# =====================================================================
# # Social engineering.  Some folk seem to know about "make" but not
# # about "configure".  (Unix users that learned before autoconf.)
# # Let's update them...

dist-hook:
	@echo "Adding a place holder confvars.ads.frame.in file..."
	@echo "-- Place holder confvars.ads.frame.in to keep --gnits happy..." > ${distdir}/confvars.ads.frame.in
	@echo "Adding a default pre-configure Makefile..."
	@echo "#! /bin/cat"                                                              >  $(distdir)/Makefile
	@echo "# This is a silly frame with no other purpose than to stand in"           >> $(distdir)/Makefile
	@echo "# place of the real Makefile before configure is run so that"             >> $(distdir)/Makefile
	@echo "# it can remind you that you forgot to run configure."                    >> $(distdir)/Makefile
	@echo ""                                                                         >> $(distdir)/Makefile
	@echo "all:"                                                                     >> $(distdir)/Makefile
	@echo "	@echo \"*******************************************************\""       >> $(distdir)/Makefile
	@echo "	@echo \"* YOU MUST RUN ./configure BEFORE YOU CAN DO A \\\"make\\\" *\"" >> $(distdir)/Makefile
	@echo "	@echo \"*******************************************************\""       >> $(distdir)/Makefile
	@echo "	@echo \"You might want      ./configure --help\""                        >> $(distdir)/Makefile
	@echo ""                                                                         >> $(distdir)/Makefile
	@echo "# It amazes me how preverse folk are..."                                  >> $(distdir)/Makefile
	@echo "install,clean,distclean,dist,check,distcheck: all"                        >> $(distdir)/Makefile
	@echo ""                                                                         >> $(distdir)/Makefile
	@echo "# But some folk are truely dense, and will do a \"make configure\""       >> $(distdir)/Makefile
	@echo "# here instead.  For them we'll assume default options."                  >> $(distdir)/Makefile
	@echo "justconfigure:"                                                           >> $(distdir)/Makefile
	@echo "	./configure"                                                             >> $(distdir)/Makefile
	@echo ""                                                                         >> $(distdir)/Makefile
	@echo "# Doing this with an indirect target is required so that make"            >> $(distdir)/Makefile
	@echo "# doesn't just notice that configure is an apparently up to date"         >> $(distdir)/Makefile
	@echo "# file...  in which case it would do nothing."                            >> $(distdir)/Makefile
	@echo "configure: justconfigure"                                                 >> $(distdir)/Makefile
	@echo ""                                                                         >> $(distdir)/Makefile
	@echo "# Oddly usefull to me sometimes:"                                         >> $(distdir)/Makefile
	@echo "fromscratch:"                                                             >> $(distdir)/Makefile
	@echo "	aclocal"                                                                 >> $(distdir)/Makefile
	@echo "	automake --warnings=all --gnits --add-missing --copy"                    >> $(distdir)/Makefile
	@echo "	autoconf --warnings=all"                                                 >> $(distdir)/Makefile
	@echo "	./configure"                                                             >> $(distdir)/Makefile
	@echo ""                                                                         >> $(distdir)/Makefile
	@echo "# ==========  END OF DUMMY Makefile ========="                            >> $(distdir)/Makefile
	chmod a+r $(distdir)/Makefile

# =================   END of Makefile.am ==============================
