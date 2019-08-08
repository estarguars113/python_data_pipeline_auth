''' Celery settings and app '''
from celery import Celery

app = Celery(
    'tasks', 
    broker='pyamqp://guest@localhost//',
    backend='amqp'
)