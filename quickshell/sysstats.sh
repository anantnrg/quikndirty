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

network=$(ip route get 1.1.1.1 2>/dev/null | grep -q "dev" && echo 1 || echo 0)

volume=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | tr -d '%')
muted=$(pactl get-sink-mute @DEFAULT_SINK@ | grep -q yes && echo 1 || echo 0)

echo "{\"cpu\": $cpu, \"ram\": $ram_percent, \"temp\": $temp, \"net\": $network, \"vol\": $volume, \"muted\": $muted}"