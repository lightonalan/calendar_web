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

Cùng một dòng (IAB), giữ đồng bộ ở `docs/app-ads.txt` (GitHub Pages) và `public/app-ads.txt` (Rails):

```
google.com, pub-9029191201631183, DIRECT, f08c47fec0942fa0
```

**GitHub Pages (hiện tại)**

| URL | Vai trò |
|-----|---------|
| https://lightonalan.github.io/calendar_web/ | Marketing / developer website trên store |
| https://lightonalan.github.io/calendar_web/app-ads.txt | File trên project site |
| https://lightonalan.github.io/app-ads.txt | **AdMob crawl** (luôn lấy root của host, bỏ path `/calendar_web`) |

Không dùng `github.com/.../app-ads.txt` — đó là trang repo, không phải site publish.

Sau khi sửa file: push → đợi Pages cập nhật → AdMob → **Verify app** → check for updates.
