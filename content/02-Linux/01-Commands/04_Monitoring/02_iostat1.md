# iostat zed

The `iostat` command is used to monitor system input/output device loading by observing the time the devices are active in relation to their average transfer rates.

## Syntax

```
iostat [options] [interval] [count]
```

## Common Options

- `-c` : Display CPU utilization report
- `-d` : Display device utilization report
- `-k` : Display statistics in kilobytes per second
- `-m` : Display statistics in megabytes per second
- `-x` : Display extended statistics
- `-p` : Display statistics for block devices and partitions

## Examples

1. Basic iostat output:
```bash
$ iostat
Linux 5.4.0-42-generic (hostname)     07/15/2023     _x86_64_    (4 CPU)

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           2.50    0.00    1.50    0.50    0.00   95.50

Device             tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sda               2.50       30.50       20.30     450568     300124
```

2. Display extended disk statistics:
```bash
$ iostat -x
Device   rrqm/s  wrqm/s  r/s   w/s   rsec/s  wsec/s  avgrq-sz avgqu-sz await svctm %util
sda        0.00    0.50   2.00  1.50   30.50   20.30    20.32     0.01  2.50  1.20  0.42
```

3. Display CPU statistics only:
```bash
$ iostat -c
avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           2.50    0.00    1.50    0.50    0.00   95.50
```

4. Display disk statistics every 2 seconds for 5 times:
```bash
$ iostat -d 2 5
```

5. Display statistics in megabytes:
```bash
$ iostat -m
```

## Output Fields Explained

- `tps`: Transfers per second (I/O requests)
- `kB_read/s`: Amount of data read per second
- `kB_wrtn/s`: Amount of data written per second
- `kB_read`: Total amount of data read
- `kB_wrtn`: Total amount of data written
- `%util`: Percentage of CPU time during which I/O requests were issued