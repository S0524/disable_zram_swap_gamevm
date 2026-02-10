#!/system/bin/sh

sleep 60

swapoff -a

for z in /sys/block/zram*; do
    [ -e "$z/reset" ] && echo 1 > "$z/reset"
done

for h in /sys/block/hybridswap*; do
    [ -e "$h/hybridswap_enable" ] && echo 0 > "$h/hybridswap_enable"
done

setprop persist.sys.zram.enabled false
setprop persist.vendor.zram.enabled false
setprop ro.zram.enabled false
setprop vendor.zram.enabled false

echo 0 > /proc/sys/vm/swappiness
echo 65536 > /proc/sys/vm/min_free_kbytes
echo 150 > /proc/sys/vm/vfs_cache_pressure
echo 35 > /proc/sys/vm/dirty_ratio
echo 15 > /proc/sys/vm/dirty_background_ratio
echo 1 > /proc/sys/vm/overcommit_memory
echo 5 > /proc/sys/vm/compaction_proactiveness
echo 0 > /proc/sys/vm/page-cluster

exit 0