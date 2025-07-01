
# Proje Adı

## Kurulum ve Çalıştırma Adımları

### 1. Projeyi Klonlayın

```bash
git clone https://github.com/halilarslan14/docker-django-app.git
cd docker-django-app
```

### 2. Ortam Değişkenlerini Ayarlayın

Ortam değişkenlerini `.env` dosyasına ekleyin. Örnek olarak `.env.example` dosyasını kullanabilirsiniz.

### 3. Geliştirme Ortamını Başlatın

```bash
docker-compose -f development.yml up --build
```

### 4. Üretim Ortamını Başlatın

```bash
docker-compose -f production.yml up --build
```

### 5. Django Komutlarını Çalıştırma

Django yönetim komutlarını aşağıdaki şekilde çalıştırabilirsiniz:

```bash
docker-compose exec backend python manage.py <komut>
```

#### Örnekler:

- Geliştirme ortamında veritabanı migration'larını çalıştırmak için:

```bash
docker-compose -f development.yml exec web python manage.py migrate --settings=project.settings.development
```

- Geliştirme ortamında statik dosyaları toplamak için:

```bash
docker-compose -f development.yml exec web python manage.py collectstatic --noinput --settings=project.settings.development
```

- Üretim ortamında süper kullanıcı oluşturmak için:

```bash
docker-compose -f production.yml exec web python manage.py createsuperuser --settings=project.settings.production
```

- Üretim ortamında statik dosyaları toplamak için:

```bash
docker-compose -f production.yml exec web python manage.py collectstatic --noinput --settings=project.settings.production
```

---

## Katkıda Bulunma

Katkılarınız, pull request’ler ve önerileriniz bizim için değerlidir.

## Lisans

Bu proje MIT Lisansı ile lisanslanmıştır.
