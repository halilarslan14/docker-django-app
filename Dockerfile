# Dockerfile

# Bu dosya, Docker imajınızın adım adım nasıl oluşturulacağını tanımlar.
# Her bir komut, imaja yeni bir katman ekler.

# 1. TEMEL İMAJ SEÇİMİ
# FROM komutu, imajımızı hangi temel imajdan başlatacağımızı belirtir.
# 'python:3.12.4-slim': Python 3.12.4'ün minimal (daha küçük boyutlu) sürümünü içeren resmi Python imajını kullanıyoruz.
#                       'slim' etiketi, gereksiz sistem paketlerini içermediği için daha küçük imajlar oluşturur.
FROM python:3.12.4-slim

# 2. ORTAM DEĞİŞKENLERİ AYARLAMA
# ENV komutu, konteyner içinde kalıcı olacak ortam değişkenlerini ayarlar.
# PYTHONDONTWRITEBYTECODE=1: Python'ın .pyc (bytecode) dosyalarını oluşturmasını engeller.
#                            Bu, konteyner içinde disk kullanımını azaltır ve temizliği artırır.
# PYTHONUNBUFFERED=1: Python çıktılarının (print statements, loglar) arabelleğe alınmadan
#                     doğrudan stdout/stderr'a yazılmasını sağlar. Bu, Docker loglarını
#                     gerçek zamanlı olarak takip etmek için önemlidir.
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# 3. SİSTEM BAĞIMLILIKLARINI YÜKLEME
# RUN komutu, imaj oluşturma sırasında kabuk komutlarını çalıştırır.
# apt-get update: Paket listelerini günceller.
# apt-get install -y: Belirtilen sistem paketlerini kurar.
#   - netcat-openbsd: Konteynerlerin veritabanı gibi diğer servislerin hazır olmasını beklemesi için kullanılabilir.
#   - gcc: Bazı Python paketlerinin (özellikle veritabanı bağlayıcıları gibi C uzantıları olanların) derlenmesi için gereklidir.
#   - postgresql-client: PostgreSQL sunucusuna bağlanmak için gerekli olan istemci araçlarını sağlar.
#   - libpq-dev: Psycopg2 gibi PostgreSQL Python bağlayıcılarının derlenmesi için gerekli olan geliştirme kütüphaneleridir.
# apt-get clean: Yükleme sonrası APT paket önbelleğini temizler, bu da imaj boyutunu küçültmeye yardımcı olur.
RUN apt-get update \
    && apt-get install -y netcat-openbsd gcc postgresql-client libpq-dev \
    && apt-get clean

# 4. ÇALIŞMA DİZİNİNİ BELİRLEME (İlk Konum)
# WORKDIR komutu, sonraki COPY ve RUN komutlarının çalıştırılacağı varsayılan dizini ayarlar.
# Projenizin kök dizinini (Dockerfile'ın bulunduğu yer) konteyner içinde '/code' olarak ayarlıyoruz.
WORKDIR /code

# 5. PYTHON BAĞIMLILIKLARINI KOPYALAMA VE YÜKLEME
# COPY requirements.txt .: Host makinesindeki 'requirements.txt' dosyasını (proje kökünüzdeki)
#                           konteyner içindeki mevcut çalışma dizinine ('/code') kopyalar.
COPY requirements.txt .

# pip install --upgrade pip: pip paket yöneticisini en son sürüme günceller.
RUN pip install --upgrade pip

# pip install -r requirements.txt: 'requirements.txt' dosyasında listelenen tüm Python bağımlılıklarını yükler.
#                                Bu, Django, gunicorn, psycopg2-binary gibi paketleri kurar.
RUN pip install -r requirements.txt

# 6. PROJE DOSYALARINI KOPYALAMA
# COPY . .: Host makinesindeki mevcut dizindeki (proje kökü) tüm dosyaları ve klasörleri
#           konteyner içindeki mevcut çalışma dizinine ('/code') kopyalar.
#           Bu, Django projenizin 'backend' klasörü dahil tüm kodunuzu konteynere taşır.
COPY . .

# 7. ÇALIŞMA DİZİNİNİ DEĞİŞTİRME (Django için)
# WORKDIR /code/backend: Çalışma dizinini '/code/backend' olarak değiştirir.
# Bu adım, Django'nun 'manage.py' komutlarının (örneğin 'manage.py migrate', 'manage.py runserver')
# doğru dizinde çalıştırılmasını sağlar.
WORKDIR /code/backend

# 8. EXPOSE PORTU (Bilgilendirme Amaçlı)
# EXPOSE 8000: Konteynerin 8000 numaralı portu dinleyeceğini Docker'a bildirir.
#             Bu, sadece bir dokümantasyon/bilgilendirme adımıdır, aslında portu yayımlamaz.
#             Port yayımlama (mapping) işlemi 'docker-compose.yml' dosyasındaki 'ports' ayarı ile yapılır.
EXPOSE 8000

# 9. VARSAYILAN BAŞLANGIÇ KOMUTU (Opsiyonel)
# CMD ["gunicorn", "project.wsgi:application", "--bind", "0.0.0.0:8000"]: Konteyner başlatıldığında çalıştırılacak varsayılan komut.
#                                                                       Ancak, 'docker-compose.yml' dosyasındaki 'command'
#                                                                       ayarı bu CMD'yi geçersiz kılar (örter).
# production.yml'deki 'command' bu CMD'yi ezecektir.
# CMD ["gunicorn", "project.wsgi:application", "--bind", "0.0.0.0:8000"]
