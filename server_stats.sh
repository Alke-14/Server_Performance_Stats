
#!/bin/bash

echo "=========================================="
echo "        Server Performance Stats      "
echo "=========================================="

os_Status=$(hostnamectl)
echo "$os_Status"

# 1. CPU Usage
# call 1 iteration of "top", fetch cpu(s) values and subtract the value of "idle" from 100
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8"%"}')
echo "\nTotal CPU Usage: $cpu_usage"

# 2. Memory Usage (Free vs Used + %)

echo  "\nTotal Memory Usage:"
free -m | awk 'NR==2{printf "Used: %dMB, Free: %dMB, Usage: %.2f%%\n", $3, $4, $3*100/$2}'

# 3. Disk Usage (Free vs Used + %)
echo  "\nTotal Disk Usage:"
df -h --total | grep 'total' | awk '{printf "Used: %s, Free: %s, Usage: %s\n", $3, $4, $5}'

# 4. Top 5 CPU Processes
echo "\nTop 5 Processes by CPU Usage:"
ps -eo pid,ppid,cmd,%cpu --sort=-%cpu | head -n 6

# 5. Top 5 Memory Processes
echo "\nTop 5 Processes by Memory Usage:"
ps -eo pid,ppid,cmd,%mem --sort=-%mem | head -n 6

echo "=========================================="
