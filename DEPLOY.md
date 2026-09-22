# Hướng dẫn domain, hosting & deploy — Lịch Âm Website

Tài liệu này hướng dẫn đăng ký domain, chọn hosting và deploy project Rails trong thư mục `website/`.

---

## Tổng quan kiến trúc

```
Người dùng → Domain (ví dụ licham.vn)
         → Hosting (Render / Railway / VPS)
         → Rails app (marketing + privacy + app-ads.txt)
```

Ứng dụng Flutter vẫn publish trên Google Play / App Store. Website chỉ phục vụ trang marketing, policy và xác minh AdMob.

---

## Bước 1: Đăng ký domain

### Nhà đăng ký phổ biến (Việt Nam & quốc tế)

| Nhà cung cấp | Ghi chú |
|--------------|---------|
| [P.A Vietnam](https://www.pavietnam.vn) | `.vn`, hỗ trợ tiếng Việt |
| [Mat Bao](https://www.matbao.net) | Domain `.vn`, DNS dễ dùng |
| [Cloudflare Registrar](https://www.cloudflare.com/products/registrar/) | Giá gốc, DNS miễn phí |
| [Namecheap](https://www.namecheap.com) | `.com`, `.app` rẻ |

### Gợi ý tên domain

- `licham.app` hoặc `lich-am.app`
- `licham.vn`
- `lightoncalendar.com`

Sau khi mua, bạn sẽ có **DNS management** để trỏ domain về hosting.

---

## Bước 2: Chọn hosting (khuyến nghị)

### Phương án A — Render.com (dễ nhất, có free tier)

1. Tạo tài khoản tại https://render.com
2. Push code lên GitHub (repo chứa thư mục `website/`)
3. **New → Blueprint** → chọn repo → Render đọc `render.yaml`
4. Hoặc **New → Web Service**:
   - **Root Directory:** `website`
   - **Build Command:** `./bin/render-build.sh`
   - **Start Command:** `bundle exec puma -C config/puma.rb`
5. Thêm biến môi trường:
   - `RAILS_MASTER_KEY` = nội dung file `website/config/master.key`
   - `APP_HOST` = domain của bạn (ví dụ `licham.app`)
   - `SUPPORT_EMAIL` = email hỗ trợ thật
6. **Settings → Custom Domain** → thêm domain → Render cung cấp CNAME

**DNS tại nhà đăng ký domain:**

| Loại | Tên | Giá trị |
|------|-----|---------|
| CNAME | `www` | URL Render cung cấp |
| A hoặc ALIAS | `@` | IP/ALIAS theo hướng dẫn Render |

### Phương án B — Railway.app

1. https://railway.app → New Project → Deploy from GitHub
2. Set root directory: `website`
3. Railway tự detect Ruby; thêm `RAILS_MASTER_KEY`, `APP_HOST`
4. Settings → Networking → Custom Domain

### Phương án C — VPS (DigitalOcean, Vultr, AWS Lightsail)

Phù hợp nếu bạn muốn kiểm soát hoàn toàn. Cần cài Ruby 3.4+, Nginx, SSL (Let's Encrypt).

```bash
# Trên server (Ubuntu)
sudo apt update && sudo apt install -y build-essential libsqlite3-dev nginx certbot python3-certbot-nginx

# Clone repo, cd website
bundle install --deployment
RAILS_ENV=production APP_HOST=licham.app bundle exec rails db:prepare assets:precompile

# Systemd service + Nginx reverse proxy port 3000
sudo certbot --nginx -d licham.app -d www.licham.app
```

### Phương án D — Firebase Hosting (chỉ static)

Repo Flutter hiện có `firebase.json` trỏ `public/`. Bạn có thể copy `app-ads.txt` vào `public/` thay vì chạy Rails.

```bash
# Copy app-ads.txt vào Firebase public folder
cp website/public/app-ads.txt public/app-ads.txt
firebase deploy --only hosting
```

---

## Bước 3: Deploy lần đầu (Render — chi tiết)

```bash
cd website
export PATH="/opt/homebrew/opt/ruby/bin:/opt/homebrew/lib/ruby/gems/3.4.0/bin:$PATH"

bundle exec rails db:prepare
bundle exec rails assets:precompile
bundle exec rails server
```

Trên Render:

1. Connect GitHub repo
2. Copy `config/master.key` → Environment → `RAILS_MASTER_KEY`
3. Deploy → đợi build xong
4. Truy cập URL `*.onrender.com` để test
5. Thêm custom domain

---

## Bước 4: Cấu hình app-ads.txt (Google AdMob)

File tại `website/public/app-ads.txt`:

```
google.com, pub-9029191201631183, DIRECT, f08c47fec0942fa0
```

### Kiểm tra sau deploy

```bash
curl -I https://<domain-của-bạn>/app-ads.txt
curl https://<domain-của-bạn>/app-ads.txt
```

Phải trả về **200** và nội dung đúng một dòng.

### Trong AdMob Console

1. Vào https://admob.google.com
2. **Apps** → chọn app Android
3. **App settings** → **App-ads.txt**
4. Nhập **Developer website URL**: `https://<domain-của-bạn>`
5. Bấm **Verify** — Google crawl file (có thể mất vài giờ đến 24h)

**Quan trọng:** URL trong Google Play Console (Developer website) cũng nên trùng domain này.

---

## Bước 5: Liên kết với Google Play & App Store

### Google Play Console

1. **Store presence → Store settings**
2. **Website:** `https://<domain-của-bạn>`
3. **Privacy policy:** `https://<domain-của-bạn>/privacy`

### Apple App Store Connect

1. **App Information → Privacy Policy URL:** `https://<domain-của-bạn>/privacy`
2. **Marketing URL (tuỳ chọn):** `https://<domain-của-bạn>`

---

## Bước 6: SSL & bảo mật

- Render/Railway tự cấp SSL (HTTPS)
- VPS: dùng Certbot + Nginx
- Rails `production.rb` đã bật `force_ssl`

---

## Checklist trước khi go-live

- [ ] `https://<domain>/` hiển thị trang marketing
- [ ] `https://<domain>/privacy` — policy đầy đủ
- [ ] `https://<domain>/app-ads.txt` — HTTP 200
- [ ] `https://<domain>/up` — health check
- [ ] Email `SUPPORT_EMAIL` hoạt động
- [ ] Play Console / App Store có URL policy đúng
- [ ] AdMob verify app-ads.txt thành công

---

## Chi phí ước tính (tham khảo)

| Hạng mục | Chi phí/năm |
|----------|-------------|
| Domain `.com` | ~$10–15 |
| Domain `.vn` | ~300.000–800.000 VNĐ |
| Render free | $0 (sleep sau idle) |
| Render paid | từ $7/tháng |
