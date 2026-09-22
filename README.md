# Lịch Âm — Website (Ruby on Rails)

Website marketing, chính sách bảo mật và `app-ads.txt` cho ứng dụng Flutter **Lịch Âm** (`com.lighton.calendar`).

## Trang web

| URL | Mô tả |
|-----|--------|
| `/` | Trang chủ marketing |
| `/privacy` | Chính sách bảo mật |
| `/terms` | Điều khoản sử dụng |
| `/support` | Hỗ trợ & FAQ |
| `/app-ads.txt` | Xác minh AdMob |
| `/api/v1/app` | JSON thông tin app (cho mobile) |

## Chạy local

```bash
cd website
export PATH="/opt/homebrew/opt/ruby/bin:/opt/homebrew/lib/ruby/gems/3.4.0/bin:$PATH"
bundle install
bin/dev
```

Mở http://localhost:3000

Chỉ Rails (không Tailwind watch): `bin/rails server`

## Biến môi trường

| Biến | Mô tả |
|------|--------|
| `SUPPORT_EMAIL` | Email hỗ trợ (mặc định: support@lighton.app) |
| `APP_HOST` | Domain production, ví dụ `licham.app` |
| `RAILS_MASTER_KEY` | Từ `config/master.key` khi deploy |

## Deploy

Xem hướng dẫn chi tiết: [DEPLOY.md](./DEPLOY.md)

## app-ads.txt

File tĩnh tại `public/app-ads.txt`:

```
google.com, pub-9029191201631183, DIRECT, f08c47fec0942fa0
```

Sau khi deploy, Google AdMob cần truy cập được:

`https://<domain-của-bạn>/app-ads.txt`

**Lưu ý:** Domain trong AdMob phải khớp domain website (không dùng subdomain khác trừ khi cấu hình riêng).
