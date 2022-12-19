RabbitMQ Cheat Sheet
=
    rabbitmqctl list_queues

## Python Example ##
### Test Publish ###

### Test Subscribe ###

```python
import pika
import os

virtual_host = "rabbitmq-virtual-host"
exchange_name = "hello-test"
exchange_type = "durable"
broker_url = "localhost"
queue = "test.queue"
creds = ('uname','passwd')

credentials = pika.PlainCredentials(
    username=creds[0],
    password=creds[1])

connection = pika.BlockingConnection(
    pika.ConnectionParameters(
        host=broker_url, virtual_host=virtual_host, credentials=credentials))
channel = connection.channel()
channel.basic_qos(prefetch_count=1)

print(f"connected to: {broker_url}")

channel.exchange_declare(
    exchange=exchange_name, exchange_type=exchange_type,
    durable=True)

result = channel.queue_declare(
    queue=queue,
    durable=True,
    exclusive=False)

if routing_key:
    channel.queue_bind(
        exchange=exchange_name,
        queue=queue_name,
        routing_key=routing_key)
else:
    channel.queue_bind(
        exchange=exchange_name,
        queue=queue)

channel.basic_consume(
    queue=queue,
    on_message_callback=on_message, auto_ack=auto_ack)

channel.start_consuming()
```
