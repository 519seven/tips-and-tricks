# Surface Monitor Tips & Tricks # 

## Databases ##
### PostGRESql ###

### MangoDB ###

## Job Order ##

To look at the order in which jobs are run, you can find it in the `job_summary.log` under `logs` directory.

## Job Status ##

To see if jobs are executing or pending, you can find out from mongo database by commands:

```bash
db.acquisition.find({"status":"EXECUTING"});
db.acquisition.find({"status":"PENDING"});
```


