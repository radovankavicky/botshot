import os
from celery import Celery

from botshot.tasks import *

os.environ.setdefault('DJANGO_SETTINGS_MODULE', '{APP_NAME}.settings')

redis_url = settings.CELERY_BROKER_URL

app = Celery('{APP_NAME}', backend='redis', broker=redis_url)
app.conf.update(BROKER_URL=redis_url,
                CELERY_RESULT_BACKEND=redis_url)

app.autodiscover_tasks(lambda: settings.INSTALLED_APPS)
