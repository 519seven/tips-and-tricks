# MongoDB Tips & Tricks

## Connect ##
```bash
# this works in our environment
mongo --username jobmanager --host mongodb-service --port 27017 --authenticationDatabase admin jobs

# another method (doesn't work in our environment)
sh-4.2$ mongo --host $MDM_MONGO_SVC_SERVICE_HOST:$MDM_MONGO_SVC_SERVICE_PORT/$SURFACE_MONITOR_MONGO_DATABASE --username $SURFACE_MONITOR_MONGO_USER --password --authenticationDatabase admin
```

## Query ##

```bash
db.acquisition.find({"status":"EXECUTING"});
 
db.acquisition.find({"status":"PENDING"});
```
