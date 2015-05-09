# The automake files generally assume that you are in C, and don't really
# support other languages all that well.  But we'll do what we can.

# Housekeeping.
SHELL=@SHELL@

bin_SCRIPTS = words
# Yes, I know it isn't a script.  But it prevents automake
# from making assumptions about how it should be built.

EXTRA_DIST = words.adb
# And, unfortunately, it doesn't know to export the prerequisites.

# There are two ways to procede here.  gnatmake does everything that make
#Jnormally does.  (Traces dependencies, recompiles as needed, etc.)
# SO, you can let gnatmake do essentially everything, and have make only do
# the GNU sorts of things (make install, etc.)
# OR, you can let make do everything and let gnat do the minimum
# possible, and let make/automake do everything.

# In the first case all you need to do is have a target for each final
# executable, and dump all the sources into a EXTRA_DIST.  This is
# probably the right choice if you have gnat.

# In the second case, you have a hope of maintaining some portability, and
# ability to handle Ada compilers other than the gnat in the GNU compiler
# collection.  (Although the m4 macros currently in adaproject have some
# gnat specific assumptions.)

# I've chosen the second choice here...
# The first choice would look like:
#
# words${EXEEXT}: confvars.ali
# 	${GNATMAKE} ${srcdir}/words
#
# Note that it still depends on confvars.adb which has special
# creation instructions below.

# So, on with the show.

# The compile step.
words.ali: words.adb confvars.ali
	${ADA} ${ADAFLAGS} -c ${srcdir}/words.adb

# Note that this is effectively the "link" step.
words${EXEEXT}: words.ali confvars.ali
	-rm -f words${EXEEXT}
	${GNATBIND} -x words.ali
	${GNATLINK} words.ali
	@echo "words built"

# ---------------------------------------------------------------------
#  C programmers have always had the help in the GNU tools of access to
#  the configure and make variables (Using config.h)
#  Here are two libraries (confvars and makevars) that serve the same
#  function for Ada programmers.
# (And, of course, the little bit of Makefile that lets the GNU tools
# build the libraries.)

# ---  confvars -- All the @SOMETHING@ variables from autoconf.

# Since this is only partly filled in by configure, we need to finish up.
# Most of these items are to turn C and SH quoted strings into something that
# Ada will take.  These are a kludge...
confvars.ads: ${top_srcdir}/confvars.ads.frame
	@echo "Building $@ ..."
	@${SED} -e 's/"@\([^@]*\)@"/UNDEFINED_CONF_VAR/' \
	        -e 's;\\\";"";g' \
		-e 's/=""";/="\\";/' \
	$< > $@
	@echo "$@ built."
# But, notice that some have values of the form (for example}
# '${prefix}/hoorgle'  where "${prefix}" is the literal text.
# For many uses, this is enough..
# The Gnu tools fill these in at make time.
# So, if you REALLY need these (such as the install directory) we have
# to play one more game... the makevars library below.

# But note, if we are not building in the source directory, that the
# autoconf unit is not in the source tree, it is in the build directory.
# So... it's compiliation is slightly different than the rest.
confvars.ali: confvars.ads
	${ADA} ${ADAFLAGS} -c $<

# --- makevars --- All the autoconf variables filled in with runtime values.
#
#  Just like confvars, but all the environment
#  variables that can be set at make time are now filled in.
#  *** NOTE ***  Because the variables can be set on any make,
#  any routine that 'with's this library will get recompiled
#  on essentiall ANY make (including make install)
#  (I.E. a make, followed by make install, would have to recompile
#  it.)

# Bogus target that make always thinks is out of date.
alwaysoutofdate:

# And makevars itself.
# Note that the last few ae something a kludge to convert sh and C conventions to ada.
# There really needs to be a complete parser to deal with the problem.  But this
# will work 99% of the time.
makevars.ads: confvars.ads alwaysoutofdate
	@${SED} -e 's/^package confvars is/package makevars is/' \
		-e 's/^end confvars;/end makevars;/' \
		-e 's/UNDEFINED_CONF_VAR/UNDEFINED_MAKE_VAR/' \
		-e "s;\$${MAKEDATERPM};`${DATE} "+%a %b %d %Y"`;" \
		-e "s;\$${MAKEDATEISO};`${DATE} "+%Y-%m-%d"`;" \
		-e "s;\$${prefix};${prefix};" \
		-e "s;\$${exec_prefix};${exexprefix};" \
		-e "s;\$${bindir};${bindir};" \
		-e "s;\$${libexecdir};${libexecdir};" \
		-e "s;\$${datadir};${datadir};" \
		-e "s;\$${sysconfdir};${sysconfdir};" \
		-e "s;\$${sharedstatedir};${sharedstatedir};" \
		-e "s;\$${localstatedir};${localstatedir};" \
		-e "s;\$${libdir};${libdir};" \
		-e "s;\$${mandir};${mandir};" \
		-e "s;\$${SHELL};${SHELL};" \
		-e "s;\$${INSTALL};${INSTALL};" \
		-e "s;\$$(install_sh);${install_sh};" \
		-e "s;=\"'\(.*\)'\"\;;\"\1\"\;;" \
	        -e 's;\\";"";g' \
		-e 's/=""";/="\";/' \
	confvars.ads > makevars.ads



makevars.ali: makevars.ads
	${ADA} ${ADAFLAGS} -c $<

# ==================================================
# Let's get pickier about cleaning up.

# Specific files. -----------------------
  MOSTLYCLEANFILES = core
  CLEANFILES       = makevars.ads makevars.ali confvars.ads confvars.ali confvars.ads.frame \
                     ${bin_SCRIPTS}
# DISTCLEANFILES   =

# Specific patterns. --------------------

mostlyclean-local:
	-rm -f *.swp *~ .*~ # Old vi backup files.

clean-local: mostlyclean-local
	-rm -f *.rpm *.tar *.gz *.zip *.bz *.bz2 *.Z *.z # Things I build and don't tell make about
	-rm -f *.o *.ali *.frame

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

# =================   END of Makefile.am ==============================
