# Python Exception Handling #

## Full Control Over Exceptions ##

```python
import pika.exceptions as pe

<...>

    try:
        service.run()
    except pe.AMQPConnectionError as amqp_err:
        exc = amqp_err
        tbk = traceback.format_exception(etype=type(exc), value=exc, tb=exc.__traceback__)
        logger.debug("Traceback: %s", tbk)
        # Examine exceptions
        # If known, add descriptive error
        if any("create_connection" in tb for tb in tbk):
            logger.error('Is RabbitMQ running?')
        else:
            logger.exception(tbk)
 
```

## Capturing KeyboardInterrupt ##

[SO Discussion](https://stackoverflow.com/questions/1112343/how-do-i-capture-sigint-in-python)


Why to use this in stead of a `KeyboardInterrupt` exception? Isn't that more intuitive to use?

2 reasons. First, SIGINT can be sent to your process any number of ways (e.g., `kill -s INT <pid>`); I'm not sure if `KeyboardInterruptException` is implemented as a `SIGINT` handler or if it really only catches `Ctrl+C` presses, but either way, using a signal handler makes your intent explicit (at least, if your intent is the same as OP's). More importantly though, with a signal you don't have to wrap `try`-`catches` around everything to make them work, which can be more or less of a composability and general software engineering win depending on the structure of your application. – 

Example of why you want to trap the signal instead of catch the Exception:
    
Say you run your program and redirect the output to a log file, `./program.py > output.log`. When you press `Ctrl-C` you want your program to exit gracefully by having it log that all data files have been flushed and marked clean to confirm they are left in a known good state. But `Ctrl-C` sends `SIGINT` to all processes in a pipeline, so the shell may close `STDOUT` (now `output.log`) before `program.py` finishes printing the final log. Python will complain, `close failed in file object destructor: Error in sys.excepthook:`

```python
#!/usr/bin/env python
import signal
import sys

def signal_handler(sig, frame):
    print('You pressed Ctrl+C!')
    sys.exit(0)

signal.signal(signal.SIGINT, signal_handler)
print('Press Ctrl+C')
signal.pause()
```

