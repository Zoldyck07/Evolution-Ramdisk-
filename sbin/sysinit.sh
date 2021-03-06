#!/system/bin/sh
# JB 4.3 fw 1.9 XMS, script for evo kernel, znxt rom
# auto rooting only
# simpan file busybox, binary SU dan Superuser.apk pada /sbin di ramdisk

/sbin/busybox mount -o remount,rw /system

if /sbin/busybox test ! -f /system/xbin/su ; then
	if /sbin/busybox test ! -f /system/bin/su ; then
		/sbin/busybox cp /sbin/su /system/xbin/
		/sbin/busybox chmod 0755 /system/xbin/su
		/sbin/busybox ln -s /system/xbin/su /system/bin/su
	else
		/sbin/busybox ln -s /system/bin/su /system/xbin/su
	fi
else
	if /sbin/busybox test ! -f /system/bin/su ; then
		/sbin/busybox ln -s /system/xbin/su /system/bin/su
	fi
fi

sleep 1

if /sbin/busybox test ! -f /system/xbin/daemonsu ; then
	/system/xbin/su --daemon &
fi

if /sbin/busybox test ! -f /system/app/Superuser.apk ; then
	/sbin/busybox cp /sbin/Superuser.apk /system/app/Superuser.apk
	/sbin/busybox chmod 0644 /system/app/Superuser.apk
fi

if /sbin/busybox test ! -f /system/etc/init.d/00frandom ; then
	/sbin/busybox cp /sbin/00frandom /system/etc/init.d/00frandom
	/sbin/busybox chmod 0755 /system/etc/init.d/00frandom
fi
#Init.d 
/sbin/busybox mkdir -p /system/etc/init.d
/sbin/busybox chown -R root.root /system/etc/init.d
/sbin/busybox chmod -R 0777 /system/etc/init.d
/sbin/busybox chmod -R 0777 /system/etc/init.d/*
/system/bin/logwrapper /sbin/busybox run-parts /system/etc/init.d
touch /data/local/tmp/sysinit.txt
