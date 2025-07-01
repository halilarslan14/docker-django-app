
# Proje Adı

## Adımlar

### Projeyi klonlayın:

```bash
git clone https://github.com/halilarslan14/docker-django-app.git
cd docker-django-app
```

### Ortam değişkenlerini ekleyin

Ortam değişkenlerini `.env` dosyasına ekleyin (örnek olarak `.env.example` dosyasını kullanabilirsiniz).

### Geliştirme ortamını çalıştırmak için:

```bash
docker-compose -f development.yml up --build
```

### Üretim ortamını çalıştırmak için:

```bash
docker-compose -f production.yml up --build
```

### Django komutlarını çalıştırmak için:

```bash
docker-compose exec backend python manage.py <komut>
```

#### Örnekler:

Geliştirme ortamında migration çalıştırma:

```bash
docker-compose -f development.yml exec web python manage.py migrate --settings=project.settings.development
```

Geliştirme ortamında collectstatic çalıştırma:

```bash
docker-compose -f development.yml exec web python manage.py collectstatic --noinput --settings=project.settings.development
```

Üretim ortamında superuser oluşturma:

```bash
docker-compose -f production.yml exec web python manage.py createsuperuser --settings=project.settings.production
```

Üretim ortamında collectstatic çalıştırma:

```bash
docker-compose -f production.yml exec web python manage.py collectstatic --noinput --settings=project.settings.production
```

---

## Katkıda Bulunma

Pull request’ler ve öneriler memnuniyetle karşılanır.

## Lisans

MIT Lisansı
