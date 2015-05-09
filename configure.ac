dnl Process this file with autoconf to produce a configure script.

AC_INIT([words],[0.97],[christopherpfair@comcast.net])

AC_PREREQ([2.7.0])         dnl Let us assume a recent autoconf
AM_INIT_AUTOMAKE([1.7.0])  dnl and automake

AC_PROG_INSTALL

AM_PROG_ADA
AM_PROG_WORKING_ADA

AC_ARG_ENABLE([debug],
[  --enable-debug          Turn on debugging options],
[ADAFLAGS="-I. -O2 -g -gnatf -gnatwa -gnaty"],
[ADAFLAGS="-I. -O2"])
AC_SUBST([ADAFLAGS])

AC_PATH_PROG([ACLOCAL], [aclocal], [aclocal], [FAIL])
if test "${ACLOCAL}" = "FAIL"; then
    AC_MSG_ERROR([Can't continue: aclocal needed but not found])
fi

AC_PATH_PROG([AUTOCONF], [autoconf], [autoconf], [FAIL])
if test "${AUTOCONF}" = "FAIL"; then
    AC_MSG_ERROR([Can't continue: autoconf needed but not found])
fi
AC_PATH_PROG([AUTOMAKE], [automake], [automake], [FAIL])
if test "${AUTOMAKE}" = "FAIL"; then
    AC_MSG_ERROR([Can't continue: automake needed but not found])
fi

AC_PATH_PROG([SED], [sed], [sed], [FAIL])
if test "${SED}" = "FAIL"; then
    AC_MSG_ERROR([Can't continue: sed needed but not found])
fi
AC_SUBST([SED])

AC_CHECK_PROG([GNATMAKE], [gnatmake], [gnatmake], [FAIL])
if test "${GNATMAKE}" = "FAIL"; then
    AC_MSG_ERROR([Can't continue: gnatmake needed but not found])
fi
AC_SUBST([GNATMAKE])
AC_CHECK_PROG([GNATBIND], [gnatbind], [gnatbind], [FAIL])
if test "${GNATBIND}" = "FAIL"; then
    AC_MSG_ERROR([Can't cotinue; gnatbind needed but not found]);
fi
AC_SUBST([GNATBIND])
AC_CHECK_PROG([GNATLINK], [gnatlink], [gnatlink], [FAIL])
if test "${GNATLINKi}" = "FAIL"; then
    AC_MSG_ERROR([Can't continue: gnatlink needed but not found])
fi
AC_SUBST([GNATLINK])


AC_PATH_PROG([DATE], [date], [date], [FAIL])
if test "${DATE}" = "FAIL"; then
    AC_MSG_ERROR([Can't continue; date program needed but not found])
fi
AC_SUBST([DATE])


dnl --- Time of configure.
CONFDATEISO="`${DATE} "+%Y-%m-%d"`"
CONFDATERPM="`${DATE} "+%a %b %d %Y"`"
AC_SUBST([CONFDATEISO]) dnl ISO flavor.
AC_SUBST([CONFDATERPM]) dnl Redhat package manager flavor.

dnl Place holder for make time.
MAKEDATEISO='${MAKEDATEISO}'
MAKEDATERPM='${MAKEDATERPM}'
AC_SUBST([MAKEDATEISO])
AC_SUBST([MAKEDATERPM])

dnl At this point the configure script clearly knows about all the variables that the
dnl user has done an AC_SUBST() call on, and the ones that autoconf itself has done
dnl for the usual reasons.    So, we can now walk autoconfs list (ac_subst_vars) and
dnl produce an Ada library that has those variables.

CONFVARS="./confvars.ads.frame.in";
echo "adaproject: Creating ${CONFVARS} by walking autoconf's variables..."
echo "-- Configure time GNU tool variables"                                          >  ${CONFVARS} || exit 1
echo "-- This package was automagicly produced by configure for the ${PACKAGE_NAME}" >> ${CONFVARS} || exit 1
echo "-- program.   Please don't try to edit it...  if at all practical change the"  >> ${CONFVARS} || exit 1
echo "-- configure.ac file that produced it instead."                                >> ${CONFVARS} || exit 1
echo "-- Produced ${CONFDATERPM}"                                                    >> ${CONFVARS} || exit 1
echo "-- by the adaproject code for the ${PACKAGE} package."                         >> ${CONFVARS} || exit 1
echo ""                                                                              >> ${CONFVARS} || exit 1
echo "-- Note that this is created at configuration time so that if the user has"    >> ${CONFVARS} || exit 1
echo "-- added variable sitems to configure.ac they are reflected in the Ada"        >> ${CONFVARS} || exit 1
echo "-- confvars."                                                                  >> ${CONFVARS} || exit 1
echo ""                                                                              >> ${CONFVARS} || exit 1
echo "package confvars is"                                                           >> ${CONFVARS} || exit 1
echo ""                                                                              >> ${CONFVARS} || exit 1
echo "    -- We need to mark variables known but with no values set..."              >> ${CONFVARS} || exit 1
echo "    UNDEFINED_CONF_VAR: constant string := \"??????????\";"                    >> ${CONFVARS} || exit 1
echo "    -- To insure that the variable is used, and not just the string value,"    >> ${CONFVARS} || exit 1
echo "    -- this value is likely to change each release."                           >> ${CONFVARS} || exit 1
echo ""                                                                              >> ${CONFVARS} || exit 1
for VARIABLE in ${ac_subst_vars}; do
    # Generally, we can just use the variable name in autoconf as the variable name in Ada.
    VNAME="${VARIABLE}"
    # Of course, if the autoconf variable has a name that is also an Ada reserved word, we
    # have to change it.  Since Ada reserved words don't have underscores, we'll just append
    # "_V" to the name we have.
    if  echo "${VNAME}" | egrep -i "^(abort|abs|abstract|accept|access|aliased|all|and|array|at|begin|body|case|constant|declare|delay|delta|digits|do|else|elsif|end|entry|exception|exit|for|function|generic|goto|if|in|is|limited|loop|mod|new|not|null|of|or|others|out|package|pragma|private|procedure|protected|raise|range|record|rem|renames|requeue|return|reverse|select|separate|subtype|tagged|task|terminate|then|type|until|use|wehn|while|whth|xor)$" > /dev/null ; then
       echo "    -- Note: configure variable was ${VNAME}, but that is an ada keyword" >> ${CONFVARS} || exit 1
       VNAME="${VNAME}_V";
    fi;
    # But autoconf also allows names that are syntaticly bad for Ada, and we have to
    # munge those to be at least legal.
    if echo "${VNAME}" | grep "__" > /dev/null ; then
       echo "    -- Note: configure variable was actually ${VNAME}, but that would not have worked as an Ada identifier." >> ${CONFVARS} || exit 1
       VNAME="`echo "${VNAME}" | ${SED} -e 's/__/_d_/g'`"
    fi
    echo "    ${VNAME}: Constant String :=\"@${VARIABLE}@\";" >> ${CONFVARS} || exit 1
    echo ""                                                   >> ${CONFVARS} || exit 1
done;
echo "end confvars;" >> ${CONFVARS} || exit 1


AC_CONFIG_FILES([Makefile src/Makefile confvars.ads.frame])
AC_OUTPUT
echo "Configure of ${PACKAGE_NAME} finished. Run 'make' to build ${PACKAGE_NAME}"
