#!/bin/bash

# Tạo file Python
cat << EOF > /opt/auto_script.py
#!/usr/bin/env python3

import subprocess
import datetime
import time

def main():
    while True:
        # Truy cập link 1
        subprocess.run(["curl", "-s", "https://muafb88.com/cron/bank.php"])

        # Ghi log
        log("Truy cap link https://muafb88.com/cron/bank.php")

        # Truy cập link 2
        subprocess.run(["curl", "-s", "https://muafb.net/cron/bank.php"])

        # Ghi log
        log("Truy cap link https://muafb.net/cron/bank.php")

        # Chờ 5 giây
        time.sleep(5)

def log(message):
    # Lấy thời gian hiện tại
    current_time = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    
    # In ra màn hình
    print(f"{current_time} - {message}")

if __name__ == "__main__":
    main()
EOF

# Tạo và cấp quyền thực thi cho script systemd
cat << EOF | sudo tee /etc/systemd/system/auto_script.service
[Unit]
Description=Auto Script

[Service]
ExecStart=/usr/bin/python3 /opt/auto_script.py
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# Kích hoạt và khởi động service
sudo systemctl daemon-reload
sudo systemctl enable auto_script.service
sudo systemctl start auto_script.service

# Thêm cron job để chạy script khi khởi động
(crontab -l 2>/dev/null; echo "@reboot /usr/bin/python3 /opt/auto_script.py") | crontab -

echo "Script đã được cài đặt và sẽ tự động chạy ngay cả khi bạn không kết nối với VPS."
