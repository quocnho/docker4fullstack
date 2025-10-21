#!/bin/bash

# Domain Setup Script
# Cấu hình domain local tự động từ tên thư mục

# Change to project root directory
cd "$(dirname "$0")/../.."
PROJECT_ROOT=$(pwd)

# Tạo domain từ tên thư mục hiện tại
PROJECT_NAME=$(basename "$PROJECT_ROOT")
DOMAIN="${PROJECT_NAME}.dev"

echo "🌐 Cấu hình domain local ${DOMAIN}..."
HOSTS_FILE="/etc/hosts"
HOST_ENTRY="127.0.0.1 ${DOMAIN}"

# Kiểm tra xem domain đã có trong hosts chưa
if grep -q "$DOMAIN" "$HOSTS_FILE"; then
    echo "✅ Domain $DOMAIN đã tồn tại trong hosts file"
else
    echo "➕ Thêm domain $DOMAIN vào hosts file..."

    # Yêu cầu quyền sudo để chỉnh sửa hosts file
    if [ "$EUID" -ne 0 ]; then
        echo "🔑 Cần quyền sudo để chỉnh sửa hosts file..."
        echo "$HOST_ENTRY" | sudo tee -a "$HOSTS_FILE" > /dev/null
    else
        echo "$HOST_ENTRY" >> "$HOSTS_FILE"
    fi

    if [ $? -eq 0 ]; then
        echo "✅ Đã thêm domain $DOMAIN thành công!"
    else
        echo "❌ Lỗi khi thêm domain vào hosts file"
        exit 1
    fi
fi

echo ""
echo "🎉 Cấu hình hoàn tất!"
echo ""
echo "📋 Thông tin domain:"
echo "   • Project: $PROJECT_NAME"
echo "   • Domain: $DOMAIN"
echo ""
echo "🌐 Bạn có thể truy cập ứng dụng tại:"
echo "   • Website: http://$DOMAIN"
echo "   • phpMyAdmin: http://localhost:8081"
echo ""
echo "💡 Lưu ý: Container phải chạy trên port 80 để domain hoạt động"
