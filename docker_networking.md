Docker Networking Tips & Tricks
=

Create and attach
---
    docker network create -d bridge mybridge
    
    docker run --rm --network=mybridge -p=6379:6379 --name=redis redis:3-alpine
    
    docker run --rm --network=mybridge -it -p=443:443 --name=version-frontend version-frontend

Troubleshooting
---

Networking

To see what network(s) your container is on, assuming your container is called `c1`:

	docker inspect c1 -f "{{json .NetworkSettings.Networks }}"

To disconnect your container from the first network (assuming your first network is called test-net):

	docker network disconnect test-net c1

Then to reconnect it to another network (assuming it's called test-net-2):

	docker network connect test-net-2 c1

To check if two containers (or more) are on a network together:

	docker network inspect test-net -f "{{json .Containers }}"

Ports
-
	docker exec -it [container name] bash
	grep -v “rem_address” /proc/net/tcp

Using nsenter (which I do not have installed)

Get the PID of your Docker container:

	docker inspect -f '{{.State.Pid}}' container_name_or_id

For example, on my system:

	docker inspect -f '{{.State.Pid}}' c70b53d98466
	15652

And once you have the PID, use that as the argument to the target (-t) option of nsenter

For example, to run `netstat` inside the container network namespace:

	sudo nsenter -t 15652 -n netstat
	Active Internet connections (only servers)
	Proto Recv-Q Send-Q Local Address           Foreign Address         State      
	tcp        0      0 0.0.0.0:80              0.0.0.0:*               LISTEN     

Notice that this worked even though the container does not have netstat installed:

	docker exec -it c70b53d98466 netstat
	rpc error: code = 13 desc = invalid header field value "oci runtime error: exec failed:
	container_linux.go:247: starting container process caused \"exec: \\\"netstat\\\": 
	executable file not found in $PATH\"\n"

`nsenter` is part of the `util-linux` package


