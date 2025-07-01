# docker-django-app
Internship Project

# Django Docker Projesi

## Proje Hakkında
Bu proje, Django tabanlı bir web uygulamasını Docker ile konteynerize etmek amacıyla hazırlanmıştır.  
Hem geliştirme hem de üretim ortamları için yapılandırılmıştır.

## Özellikler
- Django backend  
- Docker ile kolay kurulum ve dağıtım  
- Ortam değişkenleri ile hassas bilgilerin yönetimi  
- Geliştirme ve üretim için ayrı YAML konfigürasyon dosyaları  
- Statik dosyaların yönetimi için yapılandırma  

## Kurulum ve Çalıştırma

### Gereksinimler
- Docker  
- Docker Compose  
- Git

### Adımlar
1. Projeyi klonlayın:
   ```bash
   git clone https://github.com/kullaniciadi/projeadi.git
   cd projeadi
2. Ortam değişkenlerini .env dosyasına ekleyin (örnek .env.example dosyası olabilir).

3. Geliştirme ortamını çalıştırmak için:
bash
docker-compose -f development.yml up --build

4. Üretim ortamını çalıştırmak için:
bash
docker-compose -f production.yml up --build

-- Kullanım
Django komutlarını çalıştırmak için:
bash
docker-compose exec backend python manage.py <komut>
Örnek:

bash Development ortmanıda admin kullanıcı oluşturma:
docker compose -f development.yml exec web python manage.py migrate --settings=project.settings.development

bash Production ortmanıda admin kullanıcı oluşturma:  
docker compose -f production.yml exec web python manage.py createsuperuser --settings=project.settings.production

-- Katkıda Bulunma
Pull request’ler ve öneriler memnuniyetle karşılanır.

Lisans
MIT Lisansı