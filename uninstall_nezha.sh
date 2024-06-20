#!/bin/bash

# 定义路径变量
NZ_BASE_PATH="/opt/nezha"
NZ_DASHBOARD_PATH="${NZ_BASE_PATH}/dashboard"
NZ_AGENT_PATH="${NZ_BASE_PATH}/agent"
NZ_DASHBOARD_SERVICE="/etc/systemd/system/nezha-dashboard.service"
NZ_DASHBOARD_SERVICERC="/etc/init.d/nezha-dashboard"

# 停止并禁用服务
echo "Stopping and disabling Nezha services..."
systemctl stop nezha-dashboard
systemctl disable nezha-dashboard

# 删除文件和目录
echo "Deleting Nezha files and directories..."
rm -rf "${NZ_DASHBOARD_PATH}"
rm -rf "${NZ_AGENT_PATH}"
rm -rf "${NZ_BASE_PATH}"

# 删除服务文件
echo "Deleting Nezha service files..."
rm -f "${NZ_DASHBOARD_SERVICE}"
rm -f "${NZ_DASHBOARD_SERVICERC}"

# 重新加载 systemd 配置
echo "Reloading systemd daemon..."
systemctl daemon-reload

# 提示完成
echo "Nezha files and services have been removed."

# 检查删除结果
if [ ! -d "${NZ_BASE_PATH}" ] && [ ! -f "${NZ_DASHBOARD_SERVICE}" ] && [ ! -f "${NZ_DASHBOARD_SERVICERC}" ]; then
    echo "All specified files and directories have been successfully removed."
else
    echo "Some files or directories could not be removed. Please check manually."
fi
