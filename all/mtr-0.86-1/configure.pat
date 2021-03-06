--- configure.orig	Sat Nov  5 13:26:34 2016
+++ configure	Sat Nov  5 13:32:21 2016
@@ -4996,116 +4996,6 @@
 
 #  AC_CHECK_FUNC(setuid, , AC_MSG_ERROR (I Need either seteuid or setuid))
 
-#AC_CHECK_FUNC(res_mkquery, ,
-#  AC_CHECK_LIB(bind, res_mkquery, ,
-#   AC_CHECK_LIB(resolv, res_mkquery, ,
-#     AC_CHECK_LIB(resolv, __res_mkquery, , AC_MSG_ERROR(No resolver library found)))))
-
-# See if a library is needed for res_mkquery and if so put it in RESOLV_LIBS
-RESOLV_LIBS=
-
-
-{ $as_echo "$as_me:${as_lineno-$LINENO}: checking whether library required for res_mkquery" >&5
-$as_echo_n "checking whether library required for res_mkquery... " >&6; }
-RESOLV_LIB_NONE=
-cat confdefs.h - <<_ACEOF >conftest.$ac_ext
-/* end confdefs.h.  */
-
-
-#include <netinet/in.h>
-#include <resolv.h>
-
-int
-main ()
-{
-
-int (*res_mkquery_func)(int,...) = (int (*)(int,...))res_mkquery;
-(void)(*res_mkquery_func)(0);
-
-  ;
-  return 0;
-}
-_ACEOF
-if ac_fn_c_try_link "$LINENO"; then :
-  { $as_echo "$as_me:${as_lineno-$LINENO}: result: no" >&5
-$as_echo "no" >&6; }
-	RESOLV_LIB_NONE=yes
-else
-  { $as_echo "$as_me:${as_lineno-$LINENO}: result: yes" >&5
-$as_echo "yes" >&6; }
-fi
-rm -f core conftest.err conftest.$ac_objext \
-    conftest$ac_exeext conftest.$ac_ext
-if test "x$RESOLV_LIB_NONE" = "x"; then
-	{ $as_echo "$as_me:${as_lineno-$LINENO}: checking for res_mkquery in -lbind" >&5
-$as_echo_n "checking for res_mkquery in -lbind... " >&6; }
-	STASH_LIBS="$LIBS"
-	LIBS="$STASH_LIBS -lbind"
-	cat confdefs.h - <<_ACEOF >conftest.$ac_ext
-/* end confdefs.h.  */
-
-
-#include <netinet/in.h>
-#include <resolv.h>
-
-int
-main ()
-{
-
-int (*res_mkquery_func)(int,...) = (int (*)(int,...))res_mkquery;
-(void)(*res_mkquery_func)(0);
-
-  ;
-  return 0;
-}
-_ACEOF
-if ac_fn_c_try_link "$LINENO"; then :
-  { $as_echo "$as_me:${as_lineno-$LINENO}: result: yes" >&5
-$as_echo "yes" >&6; }
-		RESOLV_LIBS=-lbind
-else
-  { $as_echo "$as_me:${as_lineno-$LINENO}: result: no" >&5
-$as_echo "no" >&6; }
-fi
-rm -f core conftest.err conftest.$ac_objext \
-    conftest$ac_exeext conftest.$ac_ext
-	if test "x$RESOLV_LIBS" = "x"; then
-		{ $as_echo "$as_me:${as_lineno-$LINENO}: checking for res_mkquery in -lresolv" >&5
-$as_echo_n "checking for res_mkquery in -lresolv... " >&6; }
-		LIBS="$STASH_LIBS -lresolv"
-		cat confdefs.h - <<_ACEOF >conftest.$ac_ext
-/* end confdefs.h.  */
-
-
-#include <netinet/in.h>
-#include <resolv.h>
-
-int
-main ()
-{
-
-int (*res_mkquery_func)(int,...) = (int (*)(int,...))res_mkquery;
-(void)(*res_mkquery_func)(0);
-
-  ;
-  return 0;
-}
-_ACEOF
-if ac_fn_c_try_link "$LINENO"; then :
-  { $as_echo "$as_me:${as_lineno-$LINENO}: result: yes" >&5
-$as_echo "yes" >&6; }
-			RESOLV_LIBS=-lresolv
-else
-  { $as_echo "$as_me:${as_lineno-$LINENO}: result: no" >&5
-$as_echo "no" >&6; }
-                        as_fn_error $? "No resolver library found" "$LINENO" 5
-fi
-rm -f core conftest.err conftest.$ac_objext \
-    conftest$ac_exeext conftest.$ac_ext
-	fi
-	LIBS="$STASH_LIBS"
-fi
-
 ac_fn_c_check_func "$LINENO" "herror" "ac_cv_func_herror"
 if test "x$ac_cv_func_herror" = xyes; then :
 
@@ -5137,92 +5027,8 @@
 fi
 
 
-
-
-if test "x$USES_IPV6" = "xyes"; then
-	{ $as_echo "$as_me:${as_lineno-$LINENO}: checking whether __res_state_ext needs to be defined" >&5
-$as_echo_n "checking whether __res_state_ext needs to be defined... " >&6; }
-	cat confdefs.h - <<_ACEOF >conftest.$ac_ext
-/* end confdefs.h.  */
-
-
-#include <netinet/in.h>
-#include <resolv.h>
-#ifdef __GLIBC__
-#define RESEXTIN6(r,i) (*(r._u._ext.nsaddrs[i]))
-#else
-#define RESEXTIN6(r,i) (r._u._ext.ext->nsaddrs[i].sin6)
-#endif
-
-int
-main ()
-{
-
-struct __res_state res;
-return RESEXTIN6(res,0).sin6_addr.s6_addr[0];
-
-  ;
-  return 0;
-}
-_ACEOF
-if ac_fn_c_try_compile "$LINENO"; then :
-  { $as_echo "$as_me:${as_lineno-$LINENO}: result: no" >&5
-$as_echo "no" >&6; }
-else
-  { $as_echo "$as_me:${as_lineno-$LINENO}: result: yes" >&5
-$as_echo "yes" >&6; }
-		{ $as_echo "$as_me:${as_lineno-$LINENO}: checking whether provided __res_state_ext definition can be compiled" >&5
-$as_echo_n "checking whether provided __res_state_ext definition can be compiled... " >&6; }
-		cat confdefs.h - <<_ACEOF >conftest.$ac_ext
-/* end confdefs.h.  */
-
-
-#include <netinet/in.h>
-#include <resolv.h>
-#ifdef __GLIBC__
-#define RESEXTIN6(r,i) (*(r._u._ext.nsaddrs[i]))
-#else
-#define RESEXTIN6(r,i) (r._u._ext.ext->nsaddrs[i].sin6)
-struct __res_state_ext {
-	union res_sockaddr_union nsaddrs[MAXNS];
-	struct sort_list {
-		int     af;
-		union {
-			struct in_addr  ina;
-			struct in6_addr in6a;
-		} addr, mask;
-	} sort_list[MAXRESOLVSORT];
-	char nsuffix[64];
-	char nsuffix2[64];
-};
-#endif
-
-int
-main ()
-{
-
-struct __res_state res;
-return RESEXTIN6(res,0).sin6_addr.s6_addr[0];
-
-  ;
-  return 0;
-}
-_ACEOF
-if ac_fn_c_try_compile "$LINENO"; then :
-  { $as_echo "$as_me:${as_lineno-$LINENO}: result: yes" >&5
-$as_echo "yes" >&6; }
-
 $as_echo "#define NEED_RES_STATE_EXT 1" >>confdefs.h
 
-else
-  { $as_echo "$as_me:${as_lineno-$LINENO}: result: no" >&5
-$as_echo "no" >&6; }
-			as_fn_error $? "Need definition for struct __res_state_ext but unable to define it." "$LINENO" 5
-fi
-rm -f core conftest.err conftest.$ac_objext conftest.$ac_ext
-fi
-rm -f core conftest.err conftest.$ac_objext conftest.$ac_ext
-fi
 
 ac_fn_c_check_decl "$LINENO" "errno" "ac_cv_have_decl_errno" "
 #include <errno.h>
