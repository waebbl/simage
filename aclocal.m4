dnl aclocal.m4 generated automatically by aclocal 1.4a

dnl Copyright (C) 1994, 1995-8, 1999 Free Software Foundation, Inc.
dnl This file is free software; the Free Software Foundation
dnl gives unlimited permission to copy and/or distribute it,
dnl with or without modifications, as long as this notice is preserved.

dnl This program is distributed in the hope that it will be useful,
dnl but WITHOUT ANY WARRANTY, to the extent permitted by law; without
dnl even the implied warranty of MERCHANTABILITY or FITNESS FOR A
dnl PARTICULAR PURPOSE.


# serial 1

# @defmac AC_PROG_CC_STDC
# @maindex PROG_CC_STDC
# @ovindex CC
# If the C compiler in not in ANSI C mode by default, try to add an option
# to output variable @code{CC} to make it so.  This macro tries various
# options that select ANSI C on some system or another.  It considers the
# compiler to be in ANSI C mode if it handles function prototypes correctly.
#
# If you use this macro, you should check after calling it whether the C
# compiler has been set to accept ANSI C; if not, the shell variable
# @code{am_cv_prog_cc_stdc} is set to @samp{no}.  If you wrote your source
# code in ANSI C, you can make an un-ANSIfied copy of it by using the
# program @code{ansi2knr}, which comes with Ghostscript.
# @end defmac

AC_DEFUN(AM_PROG_CC_STDC,
[AC_REQUIRE([AC_PROG_CC])
AC_BEFORE([$0], [AC_C_INLINE])
AC_BEFORE([$0], [AC_C_CONST])
dnl Force this before AC_PROG_CPP.  Some cpp's, eg on HPUX, require
dnl a magic option to avoid problems with ANSI preprocessor commands
dnl like #elif.
dnl FIXME: can't do this because then AC_AIX won't work due to a
dnl circular dependency.
dnl AC_BEFORE([$0], [AC_PROG_CPP])
AC_MSG_CHECKING(for ${CC-cc} option to accept ANSI C)
AC_CACHE_VAL(am_cv_prog_cc_stdc,
[am_cv_prog_cc_stdc=no
ac_save_CC="$CC"
# Don't try gcc -ansi; that turns off useful extensions and
# breaks some systems' header files.
# AIX			-qlanglvl=ansi
# Ultrix and OSF/1	-std1
# HP-UX 10.20 and later	-Ae
# HP-UX older versions	-Aa -D_HPUX_SOURCE
# SVR4			-Xc -D__EXTENSIONS__
for ac_arg in "" -qlanglvl=ansi -std1 -Ae "-Aa -D_HPUX_SOURCE" "-Xc -D__EXTENSIONS__"
do
  CC="$ac_save_CC $ac_arg"
  AC_TRY_COMPILE(
[#include <stdarg.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
/* Most of the following tests are stolen from RCS 5.7's src/conf.sh.  */
struct buf { int x; };
FILE * (*rcsopen) (struct buf *, struct stat *, int);
static char *e (p, i)
     char **p;
     int i;
{
  return p[i];
}
static char *f (char * (*g) (char **, int), char **p, ...)
{
  char *s;
  va_list v;
  va_start (v,p);
  s = g (p, va_arg (v,int));
  va_end (v);
  return s;
}
int test (int i, double x);
struct s1 {int (*f) (int a);};
struct s2 {int (*f) (double a);};
int pairnames (int, char **, FILE *(*)(struct buf *, struct stat *, int), int, int);
int argc;
char **argv;
], [
return f (e, argv, 0) != argv[0]  ||  f (e, argv, 1) != argv[1];
],
[am_cv_prog_cc_stdc="$ac_arg"; break])
done
CC="$ac_save_CC"
])
if test -z "$am_cv_prog_cc_stdc"; then
  AC_MSG_RESULT([none needed])
else
  AC_MSG_RESULT($am_cv_prog_cc_stdc)
fi
case "x$am_cv_prog_cc_stdc" in
  x|xno) ;;
  *) CC="$CC $am_cv_prog_cc_stdc" ;;
esac
])

# Do all the work for Automake.  This macro actually does too much --
# some checks are only needed if your package does certain things.
# But this isn't really a big deal.

# serial 1

dnl Usage:
dnl AM_INIT_AUTOMAKE(package,version, [no-define])

AC_DEFUN(AM_INIT_AUTOMAKE,
[AC_REQUIRE([AC_PROG_INSTALL])
dnl We require 2.13 because we rely on SHELL being computed by configure.
AC_PREREQ([2.13])
PACKAGE=[$1]
AC_SUBST(PACKAGE)
VERSION=[$2]
AC_SUBST(VERSION)
dnl test to see if srcdir already configured
if test "`CDPATH=: && cd $srcdir && pwd`" != "`pwd`" &&
   test -f $srcdir/config.status; then
  AC_MSG_ERROR([source directory already configured; run "make distclean" there first])
fi
ifelse([$3],,
AC_DEFINE_UNQUOTED(PACKAGE, "$PACKAGE", [Name of package])
AC_DEFINE_UNQUOTED(VERSION, "$VERSION", [Version number of package]))
AC_REQUIRE([AM_SANITY_CHECK])
AC_REQUIRE([AC_ARG_PROGRAM])
AM_MISSING_PROG(ACLOCAL, aclocal)
AM_MISSING_PROG(AUTOCONF, autoconf)
AM_MISSING_PROG(AUTOMAKE, automake)
AM_MISSING_PROG(AUTOHEADER, autoheader)
AM_MISSING_PROG(MAKEINFO, makeinfo)
AM_MISSING_PROG(AMTAR, tar)
AM_MISSING_INSTALL_SH
dnl We need awk for the "check" target.  The system "awk" is bad on
dnl some platforms.
AC_REQUIRE([AC_PROG_AWK])
AC_REQUIRE([AC_PROG_MAKE_SET])
AC_REQUIRE([AM_DEP_TRACK])
AC_REQUIRE([AM_SET_DEPDIR])
ifdef([AC_PROVIDE_AC_PROG_CC], [AM_DEPENDENCIES(CC)], [
   define([AC_PROG_CC], defn([AC_PROG_CC])[AM_DEPENDENCIES(CC)])])
ifdef([AC_PROVIDE_AC_PROG_CXX], [AM_DEPENDENCIES(CXX)], [
   define([AC_PROG_CXX], defn([AC_PROG_CXX])[AM_DEPENDENCIES(CXX)])])
])

#
# Check to make sure that the build environment is sane.
#

AC_DEFUN(AM_SANITY_CHECK,
[AC_MSG_CHECKING([whether build environment is sane])
# Just in case
sleep 1
echo timestamp > conftestfile
# Do `set' in a subshell so we don't clobber the current shell's
# arguments.  Must try -L first in case configure is actually a
# symlink; some systems play weird games with the mod time of symlinks
# (eg FreeBSD returns the mod time of the symlink's containing
# directory).
if (
   set X `ls -Lt $srcdir/configure conftestfile 2> /dev/null`
   if test "[$]*" = "X"; then
      # -L didn't work.
      set X `ls -t $srcdir/configure conftestfile`
   fi
   if test "[$]*" != "X $srcdir/configure conftestfile" \
      && test "[$]*" != "X conftestfile $srcdir/configure"; then

      # If neither matched, then we have a broken ls.  This can happen
      # if, for instance, CONFIG_SHELL is bash and it inherits a
      # broken ls alias from the environment.  This has actually
      # happened.  Such a system could not be considered "sane".
      AC_MSG_ERROR([ls -t appears to fail.  Make sure there is not a broken
alias in your environment])
   fi

   test "[$]2" = conftestfile
   )
then
   # Ok.
   :
else
   AC_MSG_ERROR([newly created file is older than distributed files!
Check your system clock])
fi
rm -f conftest*
AC_MSG_RESULT(yes)])

dnl AM_MISSING_PROG(NAME, PROGRAM)
AC_DEFUN(AM_MISSING_PROG, [
AC_REQUIRE([AM_MISSING_HAS_RUN])
$1=${$1-"${am_missing_run}$2"}
AC_SUBST($1)])

dnl Like AM_MISSING_PROG, but only looks for install-sh.
dnl AM_MISSING_INSTALL_SH()
AC_DEFUN(AM_MISSING_INSTALL_SH, [
AC_REQUIRE([AM_MISSING_HAS_RUN])
if test -z "$install_sh"; then
   install_sh="$ac_aux_dir/install-sh"
   test -f "$install_sh" || install_sh="$ac_aux_dir/install.sh"
   test -f "$install_sh" || install_sh="${am_missing_run}${ac_auxdir}/install-sh"
   dnl FIXME: an evil hack: we remove the SHELL invocation from
   dnl install_sh because automake adds it back in.  Sigh.
   install_sh="`echo $install_sh | sed -e 's/\${SHELL}//'`"
fi
AC_SUBST(install_sh)])

dnl AM_MISSING_HAS_RUN.
dnl Define MISSING if not defined so far and test if it supports --run.
dnl If it does, set am_missing_run to use it, otherwise, to nothing.
AC_DEFUN([AM_MISSING_HAS_RUN], [
test x"${MISSING+set}" = xset || \
  MISSING="\${SHELL} `CDPATH=: && cd $ac_aux_dir && pwd`/missing"
dnl Use eval to expand $SHELL
if eval "$MISSING --run :"; then
  am_missing_run="$MISSING --run "
else
  am_missing_run=
  AC_MSG_WARN([`missing' script is too old or missing])
fi
])

dnl See how the compiler implements dependency checking.
dnl Usage:
dnl AM_DEPENDENCIES(NAME)
dnl NAME is "CC", "CXX" or "OBJC".

dnl We try a few techniques and use that to set a single cache variable.

AC_DEFUN(AM_DEPENDENCIES,[
AC_REQUIRE([AM_SET_DEPDIR])
AC_REQUIRE([AM_OUTPUT_DEPENDENCY_COMMANDS])
ifelse([$1],CC,[
AC_REQUIRE([AC_PROG_CC])
AC_REQUIRE([AC_PROG_CPP])
depcc="$CC"
depcpp="$CPP"],[$1],CXX,[
AC_REQUIRE([AC_PROG_CXX])
AC_REQUIRE([AC_PROG_CXXCPP])
depcc="$CXX"
depcpp="$CXXCPP"],[$1],OBJC,[
am_cv_OBJC_dependencies_compiler_type=gcc],[
AC_REQUIRE([AC_PROG_][$1])
depcc="$[$1]"
depcpp=""])
AC_MSG_CHECKING([dependency style of $depcc])
AC_CACHE_VAL(am_cv_[$1]_dependencies_compiler_type,[
if test -z "$AMDEP"; then
  echo '#include "conftest.h"' > conftest.c
  echo 'int i;' > conftest.h

  am_cv_[$1]_dependencies_compiler_type=none
  for depmode in `sed -n 's/^#*\([a-zA-Z0-9]*\))$/\1/p' < "$am_depcomp"`; do
    case "$depmode" in
    nosideeffect)
      # after this tag, mechanisms are not by side-effect, so they'll
      # only be used when explicitly requested
      if test "x$enable_dependency_tracking" = xyes; then
	continue
      else
	break
      fi
      ;;
    none) break ;;
    esac
    if depmode="$depmode" \
       source=conftest.c object=conftest.o \
       depfile=conftest.Po tmpdepfile=conftest.TPo \
       $SHELL $am_depcomp $depcc -c conftest.c 2>/dev/null &&
       grep conftest.h conftest.Po > /dev/null 2>&1; then
      am_cv_[$1]_dependencies_compiler_type="$depmode"
      break
    fi
  done

  rm -f conftest.*
else
  am_cv_[$1]_dependencies_compiler_type=none
fi
])
AC_MSG_RESULT($am_cv_[$1]_dependencies_compiler_type)
[$1]DEPMODE="depmode=$am_cv_[$1]_dependencies_compiler_type"
AC_SUBST([$1]DEPMODE)
])

dnl Choose a directory name for dependency files.
dnl This macro is AC_REQUIREd in AM_DEPENDENCIES

AC_DEFUN(AM_SET_DEPDIR,[
if test -d .deps || mkdir .deps 2> /dev/null || test -d .deps; then
  DEPDIR=.deps
else
  DEPDIR=_deps
fi
AC_SUBST(DEPDIR)
])

AC_DEFUN(AM_DEP_TRACK,[
AC_ARG_ENABLE(dependency-tracking,
[  --disable-dependency-tracking Speeds up one-time builds
  --enable-dependency-tracking  Do not reject slow dependency extractors])
if test "x$enable_dependency_tracking" = xno; then
  AMDEP="#"
else
  am_depcomp="$ac_aux_dir/depcomp"
  if test ! -f "$am_depcomp"; then
    AMDEP="#"
  else
    AMDEP=
  fi
fi
AC_SUBST(AMDEP)
if test -z "$AMDEP"; then
  AMDEPBACKSLASH='\'
else
  AMDEPBACKSLASH=
fi
pushdef([subst], defn([AC_SUBST]))
subst(AMDEPBACKSLASH)
popdef([subst])
])

dnl Generate code to set up dependency tracking.
dnl This macro should only be invoked once -- use via AC_REQUIRE.
dnl Usage:
dnl AM_OUTPUT_DEPENDENCY_COMMANDS

dnl
dnl This code is only required when automatic dependency tracking
dnl is enabled.  FIXME.  This creates each `.P' file that we will
dnl need in order to bootstrap the dependency handling code.
AC_DEFUN(AM_OUTPUT_DEPENDENCY_COMMANDS,[
AC_OUTPUT_COMMANDS([
test x"$AMDEP" != x"" ||
for mf in $CONFIG_FILES; do
  case "$mf" in
  Makefile) dirpart=.;;
  */Makefile) dirpart=`echo "$mf" | sed -e 's|/[^/]*$||'`;;
  *) continue;;
  esac
  grep '^DEP_FILES *= *[^ #]' < "$mf" > /dev/null || continue
  # Extract the definition of DEP_FILES from the Makefile without
  # running `make'.
  DEPDIR=`sed -n -e '/^DEPDIR = / s///p' < "$mf"`
  test -z "$DEPDIR" && continue
  # When using ansi2knr, U may be empty or an underscore; expand it
  U=`sed -n -e '/^U = / s///p' < "$mf"`
  test -d "$dirpart/$DEPDIR" || mkdir "$dirpart/$DEPDIR"
  # We invoke sed twice because it is the simplest approach to
  # changing $(DEPDIR) to its actual value in the expansion.
  for file in `sed -n -e '
    /^DEP_FILES = .*\\\\$/ {
      s/^DEP_FILES = //
      :loop
	s/\\\\$//
	p
	n
	/\\\\$/ b loop
      p
    }
    /^DEP_FILES = / s/^DEP_FILES = //p' < "$mf" | \
       sed -e 's/\$(DEPDIR)/'"$DEPDIR"'/g' -e 's/\$U/'"$U"'/g'`; do
    # Make sure the directory exists.
    test -f "$dirpart/$file" && continue
    fdir=`echo "$file" | sed -e 's|/[^/]*$||'`
    $ac_aux_dir/mkinstalldirs "$dirpart/$fdir" > /dev/null 2>&1
    # echo "creating $dirpart/$file"
    echo '# dummy' > "$dirpart/$file"
  done
done
], [AMDEP="$AMDEP"
ac_aux_dir="$ac_aux_dir"])])

# Like AC_CONFIG_HEADER, but automatically create stamp file.

AC_DEFUN(AM_CONFIG_HEADER,
[AC_PREREQ([2.12])
AC_CONFIG_HEADER([$1])
dnl When config.status generates a header, we must update the stamp-h file.
dnl This file resides in the same directory as the config header
dnl that is generated.  We must strip everything past the first ":",
dnl and everything past the last "/".
AC_OUTPUT_COMMANDS(changequote(<<,>>)dnl
ifelse(patsubst(<<$1>>, <<[^ ]>>, <<>>), <<>>,
<<test -z "<<$>>CONFIG_HEADERS" || echo timestamp > patsubst(<<$1>>, <<^\([^:]*/\)?.*>>, <<\1>>)stamp-h<<>>dnl>>,
<<am_indx=1
for am_file in <<$1>>; do
  case " <<$>>CONFIG_HEADERS " in
  *" <<$>>am_file "*<<)>>
    echo timestamp > `echo <<$>>am_file | sed -e 's%:.*%%' -e 's%[^/]*$%%'`stamp-h$am_indx
    ;;
  esac
  am_indx=`expr "<<$>>am_indx" + 1`
done<<>>dnl>>)
changequote([,]))])


# serial 40 AC_PROG_LIBTOOL
AC_DEFUN(AC_PROG_LIBTOOL,
[AC_REQUIRE([AC_LIBTOOL_SETUP])dnl

# Save cache, so that ltconfig can load it
AC_CACHE_SAVE

# Actually configure libtool.  ac_aux_dir is where install-sh is found.
CC="$CC" CFLAGS="$CFLAGS" CPPFLAGS="$CPPFLAGS" \
LD="$LD" LDFLAGS="$LDFLAGS" LIBS="$LIBS" \
LN_S="$LN_S" NM="$NM" RANLIB="$RANLIB" \
DLLTOOL="$DLLTOOL" AS="$AS" OBJDUMP="$OBJDUMP" \
${CONFIG_SHELL-/bin/sh} $ac_aux_dir/ltconfig --no-reexec \
$libtool_flags --no-verify $ac_aux_dir/ltmain.sh $lt_target \
|| AC_MSG_ERROR([libtool configure failed])

# Reload cache, that may have been modified by ltconfig
AC_CACHE_LOAD

# This can be used to rebuild libtool when needed
LIBTOOL_DEPS="$ac_aux_dir/ltconfig $ac_aux_dir/ltmain.sh"

# Always use our own libtool.
LIBTOOL='$(SHELL) $(top_builddir)/libtool'
AC_SUBST(LIBTOOL)dnl

# Redirect the config.log output again, so that the ltconfig log is not
# clobbered by the next message.
exec 5>>./config.log
])

AC_DEFUN(AC_LIBTOOL_SETUP,
[AC_PREREQ(2.13)dnl
AC_REQUIRE([AC_ENABLE_SHARED])dnl
AC_REQUIRE([AC_ENABLE_STATIC])dnl
AC_REQUIRE([AC_ENABLE_FAST_INSTALL])dnl
AC_REQUIRE([AC_CANONICAL_HOST])dnl
AC_REQUIRE([AC_CANONICAL_BUILD])dnl
AC_REQUIRE([AC_PROG_RANLIB])dnl
AC_REQUIRE([AC_PROG_CC])dnl
AC_REQUIRE([AC_PROG_LD])dnl
AC_REQUIRE([AC_PROG_NM])dnl
AC_REQUIRE([AC_PROG_LN_S])dnl
dnl

case "$target" in
NONE) lt_target="$host" ;;
*) lt_target="$target" ;;
esac

# Check for any special flags to pass to ltconfig.
libtool_flags="--cache-file=$cache_file"
test "$enable_shared" = no && libtool_flags="$libtool_flags --disable-shared"
test "$enable_static" = no && libtool_flags="$libtool_flags --disable-static"
test "$enable_fast_install" = no && libtool_flags="$libtool_flags --disable-fast-install"
test "$ac_cv_prog_gcc" = yes && libtool_flags="$libtool_flags --with-gcc"
test "$ac_cv_prog_gnu_ld" = yes && libtool_flags="$libtool_flags --with-gnu-ld"
ifdef([AC_PROVIDE_AC_LIBTOOL_DLOPEN],
[libtool_flags="$libtool_flags --enable-dlopen"])
ifdef([AC_PROVIDE_AC_LIBTOOL_WIN32_DLL],
[libtool_flags="$libtool_flags --enable-win32-dll"])
AC_ARG_ENABLE(libtool-lock,
  [  --disable-libtool-lock  avoid locking (might break parallel builds)])
test "x$enable_libtool_lock" = xno && libtool_flags="$libtool_flags --disable-lock"
test x"$silent" = xyes && libtool_flags="$libtool_flags --silent"

# Some flags need to be propagated to the compiler or linker for good
# libtool support.
case "$lt_target" in
*-*-irix6*)
  # Find out which ABI we are using.
  echo '[#]line __oline__ "configure"' > conftest.$ac_ext
  if AC_TRY_EVAL(ac_compile); then
    case "`/usr/bin/file conftest.o`" in
    *32-bit*)
      LD="${LD-ld} -32"
      ;;
    *N32*)
      LD="${LD-ld} -n32"
      ;;
    *64-bit*)
      LD="${LD-ld} -64"
      ;;
    esac
  fi
  rm -rf conftest*
  ;;

*-*-sco3.2v5*)
  # On SCO OpenServer 5, we need -belf to get full-featured binaries.
  SAVE_CFLAGS="$CFLAGS"
  CFLAGS="$CFLAGS -belf"
  AC_CACHE_CHECK([whether the C compiler needs -belf], lt_cv_cc_needs_belf,
    [AC_TRY_LINK([],[],[lt_cv_cc_needs_belf=yes],[lt_cv_cc_needs_belf=no])])
  if test x"$lt_cv_cc_needs_belf" != x"yes"; then
    # this is probably gcc 2.8.0, egcs 1.0 or newer; no need for -belf
    CFLAGS="$SAVE_CFLAGS"
  fi
  ;;

ifdef([AC_PROVIDE_AC_LIBTOOL_WIN32_DLL],
[*-*-cygwin* | *-*-mingw*)
  AC_CHECK_TOOL(DLLTOOL, dlltool, false)
  AC_CHECK_TOOL(AS, as, false)
  AC_CHECK_TOOL(OBJDUMP, objdump, false)
  ;;
])
esac
])

# AC_LIBTOOL_DLOPEN - enable checks for dlopen support
AC_DEFUN(AC_LIBTOOL_DLOPEN, [AC_BEFORE([$0],[AC_LIBTOOL_SETUP])])

# AC_LIBTOOL_WIN32_DLL - declare package support for building win32 dll's
AC_DEFUN(AC_LIBTOOL_WIN32_DLL, [AC_BEFORE([$0], [AC_LIBTOOL_SETUP])])

# AC_ENABLE_SHARED - implement the --enable-shared flag
# Usage: AC_ENABLE_SHARED[(DEFAULT)]
#   Where DEFAULT is either `yes' or `no'.  If omitted, it defaults to
#   `yes'.
AC_DEFUN(AC_ENABLE_SHARED, [dnl
define([AC_ENABLE_SHARED_DEFAULT], ifelse($1, no, no, yes))dnl
AC_ARG_ENABLE(shared,
changequote(<<, >>)dnl
<<  --enable-shared[=PKGS]  build shared libraries [default=>>AC_ENABLE_SHARED_DEFAULT],
changequote([, ])dnl
[p=${PACKAGE-default}
case "$enableval" in
yes) enable_shared=yes ;;
no) enable_shared=no ;;
*)
  enable_shared=no
  # Look at the argument we got.  We use all the common list separators.
  IFS="${IFS= 	}"; ac_save_ifs="$IFS"; IFS="${IFS}:,"
  for pkg in $enableval; do
    if test "X$pkg" = "X$p"; then
      enable_shared=yes
    fi
  done
  IFS="$ac_save_ifs"
  ;;
esac],
enable_shared=AC_ENABLE_SHARED_DEFAULT)dnl
])

# AC_DISABLE_SHARED - set the default shared flag to --disable-shared
AC_DEFUN(AC_DISABLE_SHARED, [AC_BEFORE([$0],[AC_LIBTOOL_SETUP])dnl
AC_ENABLE_SHARED(no)])

# AC_ENABLE_STATIC - implement the --enable-static flag
# Usage: AC_ENABLE_STATIC[(DEFAULT)]
#   Where DEFAULT is either `yes' or `no'.  If omitted, it defaults to
#   `yes'.
AC_DEFUN(AC_ENABLE_STATIC, [dnl
define([AC_ENABLE_STATIC_DEFAULT], ifelse($1, no, no, yes))dnl
AC_ARG_ENABLE(static,
changequote(<<, >>)dnl
<<  --enable-static[=PKGS]  build static libraries [default=>>AC_ENABLE_STATIC_DEFAULT],
changequote([, ])dnl
[p=${PACKAGE-default}
case "$enableval" in
yes) enable_static=yes ;;
no) enable_static=no ;;
*)
  enable_static=no
  # Look at the argument we got.  We use all the common list separators.
  IFS="${IFS= 	}"; ac_save_ifs="$IFS"; IFS="${IFS}:,"
  for pkg in $enableval; do
    if test "X$pkg" = "X$p"; then
      enable_static=yes
    fi
  done
  IFS="$ac_save_ifs"
  ;;
esac],
enable_static=AC_ENABLE_STATIC_DEFAULT)dnl
])

# AC_DISABLE_STATIC - set the default static flag to --disable-static
AC_DEFUN(AC_DISABLE_STATIC, [AC_BEFORE([$0],[AC_LIBTOOL_SETUP])dnl
AC_ENABLE_STATIC(no)])


# AC_ENABLE_FAST_INSTALL - implement the --enable-fast-install flag
# Usage: AC_ENABLE_FAST_INSTALL[(DEFAULT)]
#   Where DEFAULT is either `yes' or `no'.  If omitted, it defaults to
#   `yes'.
AC_DEFUN(AC_ENABLE_FAST_INSTALL, [dnl
define([AC_ENABLE_FAST_INSTALL_DEFAULT], ifelse($1, no, no, yes))dnl
AC_ARG_ENABLE(fast-install,
changequote(<<, >>)dnl
<<  --enable-fast-install[=PKGS]  optimize for fast installation [default=>>AC_ENABLE_FAST_INSTALL_DEFAULT],
changequote([, ])dnl
[p=${PACKAGE-default}
case "$enableval" in
yes) enable_fast_install=yes ;;
no) enable_fast_install=no ;;
*)
  enable_fast_install=no
  # Look at the argument we got.  We use all the common list separators.
  IFS="${IFS= 	}"; ac_save_ifs="$IFS"; IFS="${IFS}:,"
  for pkg in $enableval; do
    if test "X$pkg" = "X$p"; then
      enable_fast_install=yes
    fi
  done
  IFS="$ac_save_ifs"
  ;;
esac],
enable_fast_install=AC_ENABLE_FAST_INSTALL_DEFAULT)dnl
])

# AC_ENABLE_FAST_INSTALL - set the default to --disable-fast-install
AC_DEFUN(AC_DISABLE_FAST_INSTALL, [AC_BEFORE([$0],[AC_LIBTOOL_SETUP])dnl
AC_ENABLE_FAST_INSTALL(no)])

# AC_PROG_LD - find the path to the GNU or non-GNU linker
AC_DEFUN(AC_PROG_LD,
[AC_ARG_WITH(gnu-ld,
[  --with-gnu-ld           assume the C compiler uses GNU ld [default=no]],
test "$withval" = no || with_gnu_ld=yes, with_gnu_ld=no)
AC_REQUIRE([AC_PROG_CC])dnl
AC_REQUIRE([AC_CANONICAL_HOST])dnl
AC_REQUIRE([AC_CANONICAL_BUILD])dnl
ac_prog=ld
if test "$ac_cv_prog_gcc" = yes; then
  # Check if gcc -print-prog-name=ld gives a path.
  AC_MSG_CHECKING([for ld used by GCC])
  ac_prog=`($CC -print-prog-name=ld) 2>&5`
  case "$ac_prog" in
    # Accept absolute paths.
changequote(,)dnl
    [\\/]* | [A-Za-z]:[\\/]*)
      re_direlt='/[^/][^/]*/\.\./'
changequote([,])dnl
      # Canonicalize the path of ld
      ac_prog=`echo $ac_prog| sed 's%\\\\%/%g'`
      while echo $ac_prog | grep "$re_direlt" > /dev/null 2>&1; do
	ac_prog=`echo $ac_prog| sed "s%$re_direlt%/%"`
      done
      test -z "$LD" && LD="$ac_prog"
      ;;
  "")
    # If it fails, then pretend we aren't using GCC.
    ac_prog=ld
    ;;
  *)
    # If it is relative, then search for the first ld in PATH.
    with_gnu_ld=unknown
    ;;
  esac
elif test "$with_gnu_ld" = yes; then
  AC_MSG_CHECKING([for GNU ld])
else
  AC_MSG_CHECKING([for non-GNU ld])
fi
AC_CACHE_VAL(ac_cv_path_LD,
[if test -z "$LD"; then
  IFS="${IFS= 	}"; ac_save_ifs="$IFS"; IFS="${IFS}${PATH_SEPARATOR-:}"
  for ac_dir in $PATH; do
    test -z "$ac_dir" && ac_dir=.
    if test -f "$ac_dir/$ac_prog" || test -f "$ac_dir/$ac_prog$ac_exeext"; then
      ac_cv_path_LD="$ac_dir/$ac_prog"
      # Check to see if the program is GNU ld.  I'd rather use --version,
      # but apparently some GNU ld's only accept -v.
      # Break only if it was the GNU/non-GNU ld that we prefer.
      if "$ac_cv_path_LD" -v 2>&1 < /dev/null | egrep '(GNU|with BFD)' > /dev/null; then
	test "$with_gnu_ld" != no && break
      else
	test "$with_gnu_ld" != yes && break
      fi
    fi
  done
  IFS="$ac_save_ifs"
else
  ac_cv_path_LD="$LD" # Let the user override the test with a path.
fi])
LD="$ac_cv_path_LD"
if test -n "$LD"; then
  AC_MSG_RESULT($LD)
else
  AC_MSG_RESULT(no)
fi
test -z "$LD" && AC_MSG_ERROR([no acceptable ld found in \$PATH])
AC_PROG_LD_GNU
])

AC_DEFUN(AC_PROG_LD_GNU,
[AC_CACHE_CHECK([if the linker ($LD) is GNU ld], ac_cv_prog_gnu_ld,
[# I'd rather use --version here, but apparently some GNU ld's only accept -v.
if $LD -v 2>&1 </dev/null | egrep '(GNU|with BFD)' 1>&5; then
  ac_cv_prog_gnu_ld=yes
else
  ac_cv_prog_gnu_ld=no
fi])
])

# AC_PROG_NM - find the path to a BSD-compatible name lister
AC_DEFUN(AC_PROG_NM,
[AC_MSG_CHECKING([for BSD-compatible nm])
AC_CACHE_VAL(ac_cv_path_NM,
[if test -n "$NM"; then
  # Let the user override the test.
  ac_cv_path_NM="$NM"
else
  IFS="${IFS= 	}"; ac_save_ifs="$IFS"; IFS="${IFS}${PATH_SEPARATOR-:}"
  for ac_dir in $PATH /usr/ccs/bin /usr/ucb /bin; do
    test -z "$ac_dir" && ac_dir=.
    if test -f $ac_dir/nm || test -f $ac_dir/nm$ac_exeext ; then
      # Check to see if the nm accepts a BSD-compat flag.
      # Adding the `sed 1q' prevents false positives on HP-UX, which says:
      #   nm: unknown option "B" ignored
      if ($ac_dir/nm -B /dev/null 2>&1 | sed '1q'; exit 0) | egrep /dev/null >/dev/null; then
	ac_cv_path_NM="$ac_dir/nm -B"
	break
      elif ($ac_dir/nm -p /dev/null 2>&1 | sed '1q'; exit 0) | egrep /dev/null >/dev/null; then
	ac_cv_path_NM="$ac_dir/nm -p"
	break
      else
	ac_cv_path_NM=${ac_cv_path_NM="$ac_dir/nm"} # keep the first match, but
	continue # so that we can try to find one that supports BSD flags
      fi
    fi
  done
  IFS="$ac_save_ifs"
  test -z "$ac_cv_path_NM" && ac_cv_path_NM=nm
fi])
NM="$ac_cv_path_NM"
AC_MSG_RESULT([$NM])
])

# AC_CHECK_LIBM - check for math library
AC_DEFUN(AC_CHECK_LIBM,
[AC_REQUIRE([AC_CANONICAL_HOST])dnl
LIBM=
case "$lt_target" in
*-*-beos* | *-*-cygwin*)
  # These system don't have libm
  ;;
*-ncr-sysv4.3*)
  AC_CHECK_LIB(mw, _mwvalidcheckl, LIBM="-lmw")
  AC_CHECK_LIB(m, main, LIBM="$LIBM -lm")
  ;;
*)
  AC_CHECK_LIB(m, main, LIBM="-lm")
  ;;
esac
])

# AC_LIBLTDL_CONVENIENCE[(dir)] - sets LIBLTDL to the link flags for
# the libltdl convenience library, adds --enable-ltdl-convenience to
# the configure arguments.  Note that LIBLTDL is not AC_SUBSTed, nor
# is AC_CONFIG_SUBDIRS called.  If DIR is not provided, it is assumed
# to be `${top_builddir}/libltdl'.  Make sure you start DIR with
# '${top_builddir}/' (note the single quotes!) if your package is not
# flat, and, if you're not using automake, define top_builddir as
# appropriate in the Makefiles.
AC_DEFUN(AC_LIBLTDL_CONVENIENCE, [AC_BEFORE([$0],[AC_LIBTOOL_SETUP])dnl
  case "$enable_ltdl_convenience" in
  no) AC_MSG_ERROR([this package needs a convenience libltdl]) ;;
  "") enable_ltdl_convenience=yes
      ac_configure_args="$ac_configure_args --enable-ltdl-convenience" ;;
  esac
  LIBLTDL=ifelse($#,1,$1,['${top_builddir}/libltdl'])/libltdlc.la
  INCLTDL=ifelse($#,1,-I$1,['-I${top_builddir}/libltdl'])
])

# AC_LIBLTDL_INSTALLABLE[(dir)] - sets LIBLTDL to the link flags for
# the libltdl installable library, and adds --enable-ltdl-install to
# the configure arguments.  Note that LIBLTDL is not AC_SUBSTed, nor
# is AC_CONFIG_SUBDIRS called.  If DIR is not provided, it is assumed
# to be `${top_builddir}/libltdl'.  Make sure you start DIR with
# '${top_builddir}/' (note the single quotes!) if your package is not
# flat, and, if you're not using automake, define top_builddir as
# appropriate in the Makefiles.
# In the future, this macro may have to be called after AC_PROG_LIBTOOL.
AC_DEFUN(AC_LIBLTDL_INSTALLABLE, [AC_BEFORE([$0],[AC_LIBTOOL_SETUP])dnl
  AC_CHECK_LIB(ltdl, main,
  [test x"$enable_ltdl_install" != xyes && enable_ltdl_install=no],
  [if test x"$enable_ltdl_install" = xno; then
     AC_MSG_WARN([libltdl not installed, but installation disabled])
   else
     enable_ltdl_install=yes
   fi
  ])
  if test x"$enable_ltdl_install" = x"yes"; then
    ac_configure_args="$ac_configure_args --enable-ltdl-install"
    LIBLTDL=ifelse($#,1,$1,['${top_builddir}/libltdl'])/libltdl.la
    INCLTDL=ifelse($#,1,-I$1,['-I${top_builddir}/libltdl'])
  else
    ac_configure_args="$ac_configure_args --enable-ltdl-install=no"
    LIBLTDL="-lltdl"
    INCLTDL=
  fi
])

dnl old names
AC_DEFUN(AM_PROG_LIBTOOL, [indir([AC_PROG_LIBTOOL])])dnl
AC_DEFUN(AM_ENABLE_SHARED, [indir([AC_ENABLE_SHARED], $@)])dnl
AC_DEFUN(AM_ENABLE_STATIC, [indir([AC_ENABLE_STATIC], $@)])dnl
AC_DEFUN(AM_DISABLE_SHARED, [indir([AC_DISABLE_SHARED], $@)])dnl
AC_DEFUN(AM_DISABLE_STATIC, [indir([AC_DISABLE_STATIC], $@)])dnl
AC_DEFUN(AM_PROG_LD, [indir([AC_PROG_LD])])dnl
AC_DEFUN(AM_PROG_NM, [indir([AC_PROG_NM])])dnl

dnl This is just to silence aclocal about the macro not being used
ifelse([AC_DISABLE_FAST_INSTALL])dnl

# Add --enable-maintainer-mode option to configure.
# From Jim Meyering

# serial 1

AC_DEFUN(AM_MAINTAINER_MODE,
[AC_MSG_CHECKING([whether to enable maintainer-specific portions of Makefiles])
  dnl maintainer-mode is disabled by default
  AC_ARG_ENABLE(maintainer-mode,
[  --enable-maintainer-mode enable make rules and dependencies not useful
                          (and sometimes confusing) to the casual installer],
      USE_MAINTAINER_MODE=$enableval,
      USE_MAINTAINER_MODE=no)
  AC_MSG_RESULT($USE_MAINTAINER_MODE)
  AM_CONDITIONAL(MAINTAINER_MODE, test $USE_MAINTAINER_MODE = yes)
  MAINT=$MAINTAINER_MODE_TRUE
  AC_SUBST(MAINT)dnl
]
)

# Define a conditional.

AC_DEFUN(AM_CONDITIONAL,
[AC_SUBST($1_TRUE)
AC_SUBST($1_FALSE)
if $2; then
  $1_TRUE=
  $1_FALSE='#'
else
  $1_TRUE='#'
  $1_FALSE=
fi])

dnl Usage:
dnl  SIM_CHECK_JPEGLIB([ACTION-IF-FOUND [, ACTION-IF-NOT-FOUND]])
dnl
dnl  Try to find the JPEG development system. If it is found, these
dnl  shell variables are set:
dnl
dnl    $sim_ac_jpegdev_cflags   (extra flags the compiler needs for jpeg lib)
dnl    $sim_ac_jpegdev_ldflags  (extra flags the linker needs for jpeg lib)
dnl    $sim_ac_jpegdev_libs     (link libraries the linker needs for jpeg lib)
dnl
dnl  The CFLAGS, LDFLAGS and LIBS flags will also be modified accordingly.
dnl  In addition, the variable $sim_cv_lib_jpegdev_avail is set to eiter
dnl  "yes" (jpeg development system found) or "no" (not found).
dnl
dnl
dnl Author: Morten Eriksen, <mortene@sim.no>.
dnl
dnl TODO:
dnl    * [mortene:20000122] make sure this work on MSWin (with
dnl      Cygwin installation)
dnl

AC_DEFUN(SIM_CHECK_JPEGLIB,[
dnl Autoconf is a developer tool, so don't bother to support older versions.
AC_PREREQ([2.13])

AC_ARG_WITH(jpeg, AC_HELP_STRING([--with-jpeg=DIR], [include support for JPEG images [default=yes]]), , [with_jpeg=yes])

sim_cv_func_jpegdev_avail=

if ! test x"$with_jpeg" = xno; then
  if ! test x"$with_jpeg" = xyes; then
    sim_ac_jpegdev_cflags="-I${with_jpeg}/include"
    sim_ac_jpegdev_ldflags="-L${with_jpeg}/lib"
  fi
  sim_ac_jpegdev_libs="-ljpeg"

  sim_ac_save_cflags=$CFLAGS
  sim_ac_save_ldflags=$LDFLAGS
  sim_ac_save_libs=$LIBS

  CFLAGS="$CFLAGS $sim_ac_jpegdev_cflags"
  LDFLAGS="$LDFLAGS $sim_ac_jpegdev_ldflags"
  LIBS="$sim_ac_jpegdev_libs $LIBS"

  AC_CACHE_CHECK([whether the libjpeg development system is available],
    sim_cv_lib_jpegdev_avail,
    [AC_TRY_LINK([#include <stdio.h>
                  #include <jpeglib.h>],
                 [(void)jpeg_read_header(0L, 0);],
                 sim_cv_lib_jpegdev_avail=yes,
                 sim_cv_lib_jpegdev_avail=no)])

  if test x"$sim_cv_lib_jpegdev_avail" = xno; then
    CFLAGS=$sim_ac_save_cflags
    LDFLAGS=$sim_ac_save_ldflags
    LIBS=$sim_ac_save_libs
  fi

  if test x"$sim_cv_lib_jpegdev_avail" = xyes; then
      ifelse($1, , :, $1)
  else
      ifelse($2, , :, $2)
  fi
fi
])

dnl Usage:
dnl  SIM_CHECK_TIFFLIB([ACTION-IF-FOUND [, ACTION-IF-NOT-FOUND]])
dnl
dnl  Try to find the TIFF development system. If it is found, these
dnl  shell variables are set:
dnl
dnl    $sim_ac_tiffdev_cflags   (extra flags the compiler needs for tiff lib)
dnl    $sim_ac_tiffdev_ldflags  (extra flags the linker needs for tiff lib)
dnl    $sim_ac_tiffdev_libs     (link libraries the linker needs for tiff lib)
dnl
dnl  The CFLAGS, LDFLAGS and LIBS flags will also be modified accordingly.
dnl  In addition, the variable $sim_cv_lib_tiffdev_avail is set to eiter
dnl  "yes" (tiff development system found) or "no" (not found).
dnl
dnl
dnl Author: Morten Eriksen, <mortene@sim.no>.
dnl
dnl TODO:
dnl    * [mortene:20000122] make sure this work on MSWin (with
dnl      Cygwin installation)
dnl

AC_DEFUN(SIM_CHECK_TIFFLIB,[
dnl Autoconf is a developer tool, so don't bother to support older versions.
AC_PREREQ([2.13])

AC_ARG_WITH(tiff, AC_HELP_STRING([--with-tiff=DIR], [include support for TIFF images [default=yes]]), , [with_tiff=yes])

sim_cv_func_tiffdev_avail=

if ! test x"$with_tiff" = xno; then
  if ! test x"$with_tiff" = xyes; then
    sim_ac_tiffdev_cflags="-I${with_tiff}/include"
    sim_ac_tiffdev_ldflags="-L${with_tiff}/lib"
  fi
  sim_ac_tiffdev_libs="-ltiff"

  sim_ac_save_cflags=$CFLAGS
  sim_ac_save_ldflags=$LDFLAGS
  sim_ac_save_libs=$LIBS

  CFLAGS="$CFLAGS $sim_ac_tiffdev_cflags"
  LDFLAGS="$LDFLAGS $sim_ac_tiffdev_ldflags"
  LIBS="$sim_ac_tiffdev_libs $LIBS"

  AC_CACHE_CHECK([whether the libtiff development system is available],
    sim_cv_lib_tiffdev_avail,
    [AC_TRY_LINK([#include <tiffio.h>],
                 [(void)TIFFOpen(0L, 0L);],
                 sim_cv_lib_tiffdev_avail=yes,
                 sim_cv_lib_tiffdev_avail=no)])

  if test x"$sim_cv_lib_tiffdev_avail" = xno; then
    CFLAGS=$sim_ac_save_cflags
    LDFLAGS=$sim_ac_save_ldflags
    LIBS=$sim_ac_save_libs
  fi

  if test x"$sim_cv_lib_tiffdev_avail" = xyes; then
      ifelse($1, , :, $1)
  else
      ifelse($2, , :, $2)
  fi
fi
])

dnl Usage:
dnl  SIM_CHECK_ZLIB([ACTION-IF-FOUND [, ACTION-IF-NOT-FOUND]])
dnl
dnl  Try to find the ZLIB development system. If it is found, these
dnl  shell variables are set:
dnl
dnl    $sim_ac_zlib_cflags   (extra flags the compiler needs for zlib)
dnl    $sim_ac_zlib_ldflags  (extra flags the linker needs for zlib)
dnl    $sim_ac_zlib_libs     (link libraries the linker needs for zlib)
dnl
dnl  The CFLAGS, LDFLAGS and LIBS flags will also be modified accordingly.
dnl  In addition, the variable $sim_cv_lib_zlib_avail is set to eiter
dnl  "yes" (zlib development system found) or "no" (not found).
dnl
dnl
dnl Author: Morten Eriksen, <mortene@sim.no>.
dnl
dnl TODO:
dnl    * [mortene:20000122] make sure this work on MSWin (with
dnl      Cygwin installation)
dnl

AC_DEFUN(SIM_CHECK_ZLIB,[
dnl Autoconf is a developer tool, so don't bother to support older versions.
AC_PREREQ([2.13])

AC_ARG_WITH(zlib, AC_HELP_STRING([--with-zlib=DIR], [zlib installation directory]), , [with_zlib=yes])

sim_cv_func_zlib_avail=

if ! test x"$with_zlib" = xno; then
  if ! test x"$with_zlib" = xyes; then
    sim_ac_zlib_cflags="-I${with_zlib}/include"
    sim_ac_zlib_ldflags="-L${with_zlib}/lib"
  fi
  sim_ac_zlib_libs="-lz"

  sim_ac_save_cflags=$CFLAGS
  sim_ac_save_ldflags=$LDFLAGS
  sim_ac_save_libs=$LIBS

  CFLAGS="$CFLAGS $sim_ac_zlib_cflags"
  LDFLAGS="$LDFLAGS $sim_ac_zlib_ldflags"
  LIBS="$sim_ac_zlib_libs $LIBS"

  AC_CACHE_CHECK([whether the zlib development system is available],
    sim_cv_lib_zlib_avail,
    [AC_TRY_LINK([#include <zlib.h>],
                 [(void)zlibVersion();],
                 sim_cv_lib_zlib_avail=yes,
                 sim_cv_lib_zlib_avail=no)])

  if test x"$sim_cv_lib_zlib_avail" = xno; then
    CFLAGS=$sim_ac_save_cflags
    LDFLAGS=$sim_ac_save_ldflags
    LIBS=$sim_ac_save_libs
  fi

  if test x"$sim_cv_lib_zlib_avail" = xyes; then
      ifelse($1, , :, $1)
  else
      ifelse($2, , :, $2)
  fi
fi
])

dnl Usage:
dnl  SIM_CHECK_PNGLIB([ACTION-IF-FOUND [, ACTION-IF-NOT-FOUND]])
dnl
dnl  Try to find the PNG development system. If it is found, these
dnl  shell variables are set:
dnl
dnl    $sim_ac_pngdev_cflags   (extra flags the compiler needs for png lib)
dnl    $sim_ac_pngdev_ldflags  (extra flags the linker needs for png lib)
dnl    $sim_ac_pngdev_libs     (link libraries the linker needs for png lib)
dnl
dnl  The CFLAGS, LDFLAGS and LIBS flags will also be modified accordingly.
dnl  In addition, the variable $sim_cv_lib_pngdev_avail is set to eiter
dnl  "yes" (png development system found) or "no" (not found).
dnl
dnl
dnl Author: Morten Eriksen, <mortene@sim.no>.
dnl
dnl TODO:
dnl    * [mortene:20000122] make sure this work on MSWin (with
dnl      Cygwin installation)
dnl

AC_DEFUN(SIM_CHECK_PNGLIB,[
dnl Autoconf is a developer tool, so don't bother to support older versions.
AC_PREREQ([2.13])

AC_ARG_WITH(png, AC_HELP_STRING([--with-png=DIR], [include support for PNG images [default=yes]]), , [with_png=yes])

sim_cv_func_pngdev_avail=

if ! test x"$with_png" = xno; then
  if ! test x"$with_png" = xyes; then
    sim_ac_pngdev_cflags="-I${with_png}/include"
    sim_ac_pngdev_ldflags="-L${with_png}/lib"
  fi
  sim_ac_pngdev_libs="-lpng"

  sim_ac_save_cflags=$CFLAGS
  sim_ac_save_ldflags=$LDFLAGS
  sim_ac_save_libs=$LIBS

  CFLAGS="$CFLAGS $sim_ac_pngdev_cflags"
  LDFLAGS="$LDFLAGS $sim_ac_pngdev_ldflags"
  LIBS="$sim_ac_pngdev_libs $LIBS"

  AC_CACHE_CHECK([whether the libpng development system is available],
    sim_cv_lib_pngdev_avail,
    [AC_TRY_LINK([#include <png.h>],
                 [(void)png_read_info(0L, 0L);],
                 sim_cv_lib_pngdev_avail=yes,
                 sim_cv_lib_pngdev_avail=no)])

  if test x"$sim_cv_lib_pngdev_avail" = xno; then
    CFLAGS=$sim_ac_save_cflags
    LDFLAGS=$sim_ac_save_ldflags
    LIBS=$sim_ac_save_libs
  fi

  if test x"$sim_cv_lib_pngdev_avail" = xyes; then
      ifelse($1, , :, $1)
  else
      ifelse($2, , :, $2)
  fi
fi
])
