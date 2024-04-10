#!/bin/bash

# Hàm truy cập và ghi log cho một link
function truy_cap_ghi_log {
  link=$1
  echo "$(date +"%Y-%m-%d %H:%M:%S") - Truy cập link $link" >> cronmain.log
  curl -s $link >> cronmain.log
}

# Truy cập link 1 và ghi log
truy_cap_ghi_log https://muafb88.com/cron/bank.php

# Truy cập link 2 và ghi log
truy_cap_ghi_log https://muafb.net/cron/bank.php

# Chờ 5 giây
sleep 5

# Lặp lại
while true; do
  truy_cap_ghi_log https://muafb88.com/cron/bank.php
  truy_cap_ghi_log https://muafb.net/cron/bank.php
  sleep 5
done
