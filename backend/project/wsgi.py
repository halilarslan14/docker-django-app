# WSGI'nin Ana Amacı Nedir?
# WSGI'nin (Web Server Gateway Interface) ana amacı, web sunucuları ile Python web uygulamaları arasında standart bir iletişim köprüsü sağlamaktır.

# Basitçe söylemek gerekirse:

# Web sunucuları (Nginx, Apache gibi), internetten gelen HTTP isteklerini alır.

# Python web uygulamaları (Django, Flask gibi), bu istekleri işler ve bir yanıt (HTML sayfası, JSON verisi vb.) oluşturur.

# WSGI, bu iki tarafın birbirini anlamasını ve sorunsuz bir şekilde veri alışverişi yapmasını sağlayan bir çevirmen veya ortak bir dil görevi görür. Bu sayede, herhangi bir WSGI uyumlu web sunucusu, herhangi bir WSGI uyumlu Python uygulamasını çalıştırabilir. Bu da hem geliştiricilere hem de sistem yöneticilerine büyük esneklik sağlar.

import os

from django.core.wsgi import get_wsgi_application

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'project.settings.development')

application = get_wsgi_application()
