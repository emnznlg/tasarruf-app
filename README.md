# Tasarruf - Harcama Takip Uygulaması

Tasarruf, günlük harcamalarınızı ve gelirlerinizi takip etmenizi sağlayan basit ve kullanışlı bir mobil uygulamadır.

## Özellikler

- Harcama ve gelir girişi
- Tarih aralığına göre filtreleme
- Toplam gelir, gider ve bakiye görüntüleme
- Açık/koyu tema desteği
- Offline çalışabilme
- Veri silme ve sıfırlama

## Teknik Detaylar

### Kullanılan Teknolojiler
- Flutter 3.x
- Riverpod (State Management)
- Drift/SQLite (Veritabanı)
- Material Design 3

### Proje Yapısı
```
lib/
├── src/
│   ├── app.dart                 # Ana uygulama widget'ı
│   ├── core/                    # Çekirdek özellikler
│   │   ├── database/           # Veritabanı işlemleri
│   │   └── theme/             # Tema yönetimi
│   ├── features/               # Özellik bazlı modüller
│   │   ├── transactions/      # İşlemler modülü
│   │   │   ├── presentation/  # UI bileşenleri
│   │   │   └── providers/    # State yönetimi
│   │   └── settings/         # Ayarlar modülü
│   └── shared/               # Paylaşılan bileşenler
```

### Veritabanı Şeması
```sql
CREATE TABLE transactions (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  amount REAL NOT NULL,
  description TEXT NOT NULL,
  date DATETIME NOT NULL,
  isExpense BOOLEAN NOT NULL
);
```

## Kurulum

1. Flutter SDK'yı yükleyin (3.x veya üzeri)
2. Java 17 yüklü olduğundan emin olun
3. Projeyi klonlayın
4. Bağımlılıkları yükleyin:
   ```bash
   flutter pub get
   ```
5. Code generation'ı çalıştırın:
   ```bash
   dart run build_runner build
   ```
6. Uygulamayı çalıştırın:
   ```bash
   flutter run
   ```

## Geliştirme

### Kod Standartları
- Material Design 3 prensipleri
- Clean Architecture prensipleri
- SOLID prensipleri
- DRY (Don't Repeat Yourself)

### State Management
- Riverpod ile reactive state management
- Provider pattern kullanımı
- Code generation ile type-safe provider'lar

### Veritabanı
- Drift (moor) ORM kullanımı
- SQLite veritabanı
- Asenkron veritabanı işlemleri

## Lisans

Bu proje MIT lisansı altında lisanslanmıştır.
