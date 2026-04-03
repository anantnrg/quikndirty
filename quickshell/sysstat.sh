#!/bin/bash

read cpu a b c prev_idle rest < /proc/stat
sleep 0.5
read cpu a2 b2 c2 idle rest < /proc/stat

prev_total=$((a + b + c + prev_idle))
total=$((a2 + b2 + c2 + idle))

diff_idle=$((idle - prev_idle))
diff_total=$((total - prev_total))

cpu=$((100 * (diff_total - diff_idle) / diff_total))

read total used <<< $(free -m | awk '/Mem:/ {print $2, $3}')
ram_percent=$((used * 100 / total))

temp=$(sensors | awk '/Tctl:/ {print int($2)}')

echo "{\"cpu\": $cpu, \"ram\": $ram_percent, \"temp\": $temp}"