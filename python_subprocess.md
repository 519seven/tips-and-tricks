# Execute shell commands in subprocess

## COMMAND LINE AUTOMATION IN PYTHON

**Noah Gift**
Lecturer, Northwestern & UC Davis & UCBerkeley | Founder, Pragmatic AI Labs


## Using subprocess.run

Simplest way to run shell commands using Python 3.5+
Takes a list of strings
```python
subprocess.run(["ls", "-l"])
```

## Dealing with Byte Strings

Byte Strings are default in subprocess
```python
res = b'repl 24 0.0 0.0 36072 3144 pts/0 R+ 03:15 0:00 ps aux\n'
print(type(res))
```
## bytes
### Byte Strings decode
```python
regular_string = res.decode("utf-8")
'repl 24 0.0 0.0 36072 3144 pts/0 R+ 03:15 0:00 ps aux\n'
print(type(regular_string))
```

## Unix status codes

Successful completion returns 0
```bash
ls -l
echo $?
0
```

Unsuccessful commands return non-zero values
```bash
ls --bogus-flag
echo $?
1
```

## Checking status codes

Run shell command and assign output
```python
out = run(["ls", "-l"])
```

`CompletedProcess` object
```python
subprocess.CompletedProcess
```

Check status code
```python
print(out.returncode)
0
```

## Non-zero status codes in `subprocess.run`

Successful status code
```python
out = run(["ls", "-l"])
print(out.returncode)
```

Unsuccessful status code
```python
bad_out = run(["ls", "--turbo"])
print(bad_out.returncode)
1
```

## Control flow for status codes

Handling user input
```python
good_user_input = "-l"
out = run(["ls", good_user_input])
```

Controlling flow based on response
```python
if out.returncode == 0 :
print("Your command was a success")
else:
print("Your command was unsuccesful")
```

# Practicing executing shell commands

# Capture output of shell commands

```
COMMAND LINE AUTOMATION IN PYTHON
```
**Noah Gift**
Lecturer, Northwestern & UC Davis & UCBerkeley | Founder, Pragmatic AI Labs


## Using the subprocess.Popen module

Captures the output of shell commands
In bash a directory listing using ls
```bash
bash-3.2$ ls
some_file.txt some_other_file.txt
```

In Python output can be captured with Popen
```python
with Popen(["ls"], stdout=PIPE) as proc:
    out = proc.readlines()
    print(out) (^)
['some_file.txt','some_other_file.txt']
```

## "with" statement

Context manager handles closing file
```python
with open("somefile.txt", "r") as output:
    # uses context manager

with Popen(["ls", "/tmp"], stdout=PIPE) as proc:
    # perform file operations
```
Simplifies using `Popen`.  Also simplifies other Python statements like reading files.

## Breaking down a real example

```python
# import Popen and PIPE to manage subprocesses
from subprocess import (Popen, PIPE)

with Popen(["ls", "/tmp"], stdout=PIPE) as proc:
    result = proc.stdout.readlines()
```

## Using communicate

`communicate`: A way of communicating with streams of a process, including waiting.
```python
proc = subprocess.Popen(...)
# Attempt to communicate for up to 30 seconds
try:
    out, err = proc.communicate(timeout= 30 ) (^)
except TimeoutExpired:
    # kill the process since a timeout was triggered
    proc.kill()
    # capture both standard output and standard error
    out, error = proc.communicate()
```

## Using PIPE

`PIPE`: Connects a standard stream (stdin, stderr, stdout)

One intuition about `PIPE` is to think of it as tube that connect to other tubes (see diagram on page 14 of "Execute Shell Commands in Subprocess.pdf")


## Required components of subprocess.Popen

`stdout`: Captures output of command
`stdout.read()`: returns output as a string
`stdout.readlines()`: returns outputs as an interator
`shell=False` is default and recommended
```python
# Unsafe!
with Popen("ls -l /tmp", shell=True, stdout=PIPE) as proc:
```

## Using stderr

`stderr`: Captures shell stderr (error output)
```python
with Popen(["ls", "/a/bad/path"], stdout=PIPE, stderr=PIPE) as proc:
    print(proc.stderr.read())
```
stderr output

```bash
b'ls: /a/bad/path: No such file or directory\n'
```

## Analyzing Results

Printing raw result:
```python
print(result)
```
Output:
```bash
[b'bar.txt\n', b'foo.txt\n']
```
Print each file:
```python
for file in result:
    print(file.strip())
```
Output:
```bash
b'bar.txt'
b'foo.txt'
```

# Practicing with the subprocess.Popen Class

- Sending input to processes

## Using Unix Pipes as input

Two ways of connecting input
1. `Popen` method
```python
proc1 = Popen(["process_one.sh"], stdout=subprocess.PIPE)
Popen(["process_two.sh"], stdin=proc1.stdout)
```
2. run method (Higher Level Abstraction)
```python
proc1 = run(["process_one.sh"], stdout=subprocess.PIPE)
run(["process_two.sh"], input=proc1.stdout)
```

## Input Pipe from Unix

Contents of the directory
```bash
ls -l
```
Output:
```bash
total 160
-rw-r--r-- 1 staff staff 13 Apr 15 06:56
-rw-r--r-- 1 staff staff 12 Apr 15 06:56 file_9.txt
```
Sends output of one command to another
```bash
ls | wc
```
```
20 20 220
```

## The string language of Unix Pipes

- Strings are the language of shell pipes
- Pass strings via STDOUT

```bash
echo "never odd or even" | rev
```
Output:
```bash
neve ro ddo reven
```

## Translating between objects and strings

Python objects contain
- data
- methods

Unix strings are
- data only
- often columnar

## User input

- Bash uses `read`.
- Python uses `input`.
- Python can also accept input from command-line libraries.
- Subprocess can pipe input to scripts that wait for user input.

# Practicing Input
- Passing arguments safely to shell commands

## User input is unpredictable

Expected input to a script
```bash
"/some/dir"
```

Actual input to a script
```bash
"/some/dir && rm -rf /all/your/dirs"
```

## Understanding `shell=True` in subprocess

- By default `shell=False`
- `shell=True` allows arbitrary code
- Best practice is to avoid `shell=True`
```bash
#shell=False is default
run(["ls", "-l"],shell=False)
```

## Using the `shlex` module

`shlex` can sanitize strings
```python
shlex.split("/tmp && rm -rf /all/my/dirs")
```
Output:
```bash
['/tmp', '&&', 'rm', '-rf', '/all/my/dirs']
```

```python
directory = shlex.split("/tmp")
cmd = ["ls"]
cmd.extend(directory)
run(cmd, shell=True)
```
Output:
```bash
CompletedProcess(args=['ls', '/tmp'], returncode=0)
```

## Defaulting to items in a list

- Best practice is using a list
- Limits mistakes
```python
with subprocess.Popen(["find", user_input, "-type", "f"],
stdout=subprocess.PIPE) as find:
#do something else in Python....
```

## The problem with security by obscurity

- House key under the doormat
- Key cards for every door
- Integrated security is best

## Security best practices for subprocess

Always use `shell=False`
Assume all users are malicious
Never use security by obscurity
Always use the principle of least privilege
Reduce complexity

# Security focused practice!

