--- loginrec.c~	Mon Jan 17 11:15:31 2011
+++ loginrec.c	Fri Jul 25 16:38:01 2014
@@ -788,12 +788,12 @@
 	/* this is just a 128-bit IPv6 address */
 	if (li->hostaddr.sa.sa_family == AF_INET6) {
 		sa6 = ((struct sockaddr_in6 *)&li->hostaddr.sa);
-		memcpy(ut->ut_addr_v6, sa6->sin6_addr.s6_addr, 16);
+		memcpy(utx->ut_addr_v6, sa6->sin6_addr.s6_addr, 16);
 		if (IN6_IS_ADDR_V4MAPPED(&sa6->sin6_addr)) {
-			ut->ut_addr_v6[0] = ut->ut_addr_v6[3];
-			ut->ut_addr_v6[1] = 0;
-			ut->ut_addr_v6[2] = 0;
-			ut->ut_addr_v6[3] = 0;
+			utx->ut_addr_v6[0] = utx->ut_addr_v6[3];
+			utx->ut_addr_v6[1] = 0;
+			utx->ut_addr_v6[2] = 0;
+			utx->ut_addr_v6[3] = 0;
 		}
 	}
 # endif
