# iostat

`iostat` (Input/Output Statistics) is a powerful Linux command that provides real-time statistics about disk I/O activity.

## Basic Syntax

```bash
iostat [options] [delay [count]]
```

## Common Options

- `-d` : Display disk statistics
- `-k` : Display statistics in kilobytes
- `-m` : Display statistics in megabytes
- `-n` : Display header only once
- `-x` : Display extended statistics

## Example Output

```bash
$ iostat
Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm%   util%  r_await w_await  svctm%   util%
sda               0.00     0.00    0.00    0.00     0.00     0.00    0.00     0.00    0.00    0.00    0.00     0.00   0.00     0.00    0.00     0.00         0.00
sdb               0.00     0.00    0.00    0.00     0.00     0.00    0.00     0.00    0.00    0.00    0.00     0.00   0.00     0.00    0.00     0.00         0.00
```

## Field Descriptions

- `rrqm/s`: Number of read requests per second
- `wrqm/s`: Number of write requests per second
- `r/s`: Number of reads per second
- `w/s`: Number of writes per second
- `rMB/s`: Number of read bytes per second in megabytes
- `wMB/s`: Number of write bytes per second in megabytes
- `avgrq-sz`: Average request size in bytes
- `avgqu-sz`: Average queue length
- `await`: Average wait time in milliseconds
- `r_await`: Average read wait time in milliseconds
- `w_await`: Average write wait time in milliseconds
- `svctm%`: Service time percentage             (utilization)
- `util%`: Utilization percentage

## Additional Examples

### Display Disk Statistics
```bash
$ iostat -d
Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm%   util%  r_await w_await  svctm%   util%
sda               0.00     0.00    0.00    0.00     0.00     0.00    0.00     0.00    0.00    0.00    0.00     0.00   0.00     0.00    0.00     0.00         0.00
sdb               0.00     0.00    0.00    0.00     0.00     0.00    0.00     0.00    0.00    0.00    0.00     0.00   0.00     0.00    0.00     0.00         0.00
```

### Display Extended Statistics
```bash
$ iostat -x
Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm%   util%  r_await w_await  svctm%   util%   r_await w_await  svctm%   util%
sda               0.00     0.00    0.00    0.00     0.00     0.00    0.00     0.00    0.00    0.00    0.00     0.00   0.00     0.00    0.00     0.00         0.00         0.00    0.00     0.00         0.00
