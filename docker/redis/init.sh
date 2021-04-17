#  WARNING you have Transparent Huge Pages (THP) support enabled in your kernel.
#  This will create latency and memory usage issues with Redis.
#  To fix this issue run the command 'echo never > /sys/kernel/mm/transparent_hugepage/enabled' as root,
#  and add it to your /etc/rc.local in order to retain the setting after a reboot.
#  Redis must be restarted after THP is disabled.

echo never > /sys/kernel/mm/transparent_hugepage/enabled
echo never > /sys/kernel/mm/transparent_hugepage/defrag

# WARNING: The TCP backlog setting of 511 cannot be enforced
# because /proc/sys/net/core/somaxconn is set to the lower value of 128.

# TCPバックログ(待ち受け可能なTCPセッション数)をOSの既定値である128からRedisの既定値である511に変更する
sysctl -w net.core.somaxconn=511

# WARNING overcommit_memory is set to 0! Background save may fail under low memory condition.
# To fix this issue add 'vm.overcommit_memory = 1' to /etc/sysctl.conf and then reboot
# or run the command 'sysctl vm.overcommit_memory=1' for this to take effect.
# The overcommit_memory has 3 options.
# 0, the system kernel check if there is enough memory to be allocated to the process or not,
# if not enough, it will return errors to the process.
# 1, the system kernel is allowed to allocate the whole memory to the process
# no matter what the status of memory is.
# 2, the system kernel is allowed to allocate a memory whose size could be bigger than
# the sum of the size of physical memory and the size of exchange workspace to the process.

# 0：デフォルト。メモリ要求があったときに空き容量がなかったら実行中のプロセスを強制終了し、メモリを強引に確保する。
# 1：メモリを使い切るまでは十分なメモリがあるように振る舞う。それ以外は 0 と同じ。
# 2：メモリ要求があったときに空き容量がない場合は、メモリ確保ができないエラーを発生させる。

sysctl vm.overcommit_memory=1

# start redis server

redis-server
