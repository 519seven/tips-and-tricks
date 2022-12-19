## Subprocess ##

### Chaining together multiple shell commands ###

To use a pipe with the subprocess module, you have to pass `shell=True`.

However, this isn't really advisable for various reasons, not least of which is security. Instead, create the `ps` and `grep` processes separately, and pipe the output from one into the other, like so:

```python
ps = subprocess.Popen(('ps', '-A'), stdout=subprocess.PIPE)
output = subprocess.check_output(('grep', 'process_name'), stdin=ps.stdout)
ps.wait()
```

The simple solution is to call `subprocess.check_output(('ps', '-A'))` and then `str.find` on the output.

