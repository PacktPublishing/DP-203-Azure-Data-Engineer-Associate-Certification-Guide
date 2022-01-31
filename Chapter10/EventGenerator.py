import asyncio
from azure.eventhub.aio import EventHubProducerClient
from azure.eventhub import EventData

import json
import datetime
import uuid
import random
import time

async def run():
    # Create a producer client to send messages to the event hub.
    # Specify a connection string to your event hubs namespace and
    # the event hub name.
    
    producer = EventHubProducerClient.from_connection_string(conn_str="<INSERT CONN STR>", eventhub_name="<INSERT EVENTHUB NAME>")

    city_list = ["San Franciso", "San Jose", "Los Angesles", "Seattle","Austin", "Dallas", "Denver", "New York", "Atlanta", "Miami", "Phoenix", "Tempe"]
    async with producer:
        for i in range(0, 600):  
            # Create a batch.
            event_data_batch = await producer.create_batch()
            tripdetail1 = {'tripId': str(uuid.uuid4()), 'createdAt': str(datetime.datetime.utcnow()), 'startLocation': random.choice(city_list), 'endLocation': random.choice(city_list), 
            'distance': random.randint(10, 1000), 'fare': random.randint(100, 1000) }
            tripdetail2 = {'tripId': str(uuid.uuid4()), 'createdAt': str(datetime.datetime.utcnow()), 'startLocation': random.choice(city_list), 'endLocation': random.choice(city_list), 
            'distance': random.randint(10, 1000), 'fare': random.randint(100, 1000) }
            tripdetail3 = {'tripId': str(uuid.uuid4()), 'createdAt': str(datetime.datetime.utcnow()), 'startLocation': random.choice(city_list), 'endLocation': random.choice(city_list), 
            'distance': random.randint(10, 1000), 'fare': random.randint(100, 1000) }

            print (tripdetail1);
            print (tripdetail2);
            print (tripdetail3);
            # Add events to the batch.
            event_data_batch.add(EventData(json.dumps(tripdetail1)))
            event_data_batch.add(EventData(json.dumps(tripdetail2)))
            event_data_batch.add(EventData(json.dumps(tripdetail3)))
            event_data_batch.add(EventData(json.dumps(tripdetail1)))


            # Send the batch of events to the event hub.
            await producer.send_batch(event_data_batch)
            time.sleep(1)

loop = asyncio.get_event_loop()
loop.run_until_complete(run())

