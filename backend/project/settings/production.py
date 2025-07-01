# backend/project/settings/production.py

from .base import *
from decouple import config

DEBUG = config('DJANGO_DEBUG', default=False, cast=bool)

ALLOWED_HOSTS_STR = config('DJANGO_ALLOWED_HOSTS', default='')
ALLOWED_HOSTS = [host.strip() for host in ALLOWED_HOSTS_STR.split(',')] if ALLOWED_HOSTS_STR else []

# Üretime özel ek güvenlik, cache vs. buraya eklenir

# Veritabanı Ayarları:
# https://docs.djangoproject.com/en/5.2/ref/settings/#databases
# 'default': Uygulamanızın varsayılan olarak kullanacağı veritabanı bağlantısı.
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql', # Kullanılacak veritabanı motoru (PostgreSQL).
        'NAME': config('DB_NAME'), # Veritabanının adı, '.env' dosyasından okunur.
        'USER': config('DB_USER'), # Veritabanı kullanıcı adı, '.env' dosyasından okunur.
        'PASSWORD': config('DB_PASSWORD'), # Veritabanı parolası, '.env' dosyasından okunur.
        'HOST': config('DB_HOST', 'db'), # Veritabanı sunucusunun adresi.
                                         # 'db': Docker Compose ağındaki 'db' servisinin adıdır.
                                         # Eğer '.env'de yoksa 'db' varsayılan olarak kullanılır.
        'PORT': config('DB_PORT', '5432', cast=int), # Veritabanı port numarası.
                                                    # Eğer '.env'de yoksa '5432' varsayılan olarak kullanılır ve tamsayıya çevrilir.
    }
}