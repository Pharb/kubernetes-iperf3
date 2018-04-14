# kubernetes-iperf3
Simple wrapper around iperf3 to measure network bandwidth from all nodes of a Kubernetes cluster.

## How to use
*Make sure you are using the correct cluster context before running this script: `kubectl config current-context`*
```
$ ./iperf3.sh
```

Any options supported by iperf3 can be added, e.g.:

```
$ ./iperf3.sh -t 2
```

### Output:
```
deployment.apps "iperf3-server-deployment" created
service "iperf3-server" created
daemonset.apps "iperf3-clients" created
Waiting for iperf3 server to start...
Waiting for iperf3 server to start...
Waiting for iperf3 server to start...
Server is running

Client on 172.20.47.197:  Connecting to host iperf3-server, port 5201
Client on 172.20.47.197:  [  4] local 100.96.0.28 port 37580 connected to 100.65.13.40 port 5201
Client on 172.20.47.197:  [ ID] Interval           Transfer     Bandwidth       Retr  Cwnd
Client on 172.20.47.197:  [  4]   0.00-1.00   sec  3.59 GBytes  30.8 Gbits/sec    0   4.00 MBytes
Client on 172.20.47.197:  [  4]   1.00-2.00   sec  3.66 GBytes  31.5 Gbits/sec    0   4.00 MBytes
Client on 172.20.47.197:  - - - - - - - - - - - - - - - - - - - - - - - - -
Client on 172.20.47.197:  [ ID] Interval           Transfer     Bandwidth       Retr
Client on 172.20.47.197:  [  4]   0.00-2.00   sec  7.25 GBytes  31.1 Gbits/sec    0             sender
Client on 172.20.47.197:  [  4]   0.00-2.00   sec  7.25 GBytes  31.1 Gbits/sec                  receiver
Client on 172.20.47.197:
Client on 172.20.47.197:  iperf Done.

Client on 172.20.57.129:  Connecting to host iperf3-server, port 5201
Client on 172.20.57.129:  [  4] local 100.96.1.31 port 55166 connected to 100.65.13.40 port 5201
Client on 172.20.57.129:  [ ID] Interval           Transfer     Bandwidth       Retr  Cwnd
Client on 172.20.57.129:  [  4]   0.00-1.00   sec   954 MBytes  8.00 Gbits/sec    5   3.10 MBytes
Client on 172.20.57.129:  [  4]   1.00-2.00   sec   948 MBytes  7.95 Gbits/sec    1   4.22 MBytes
Client on 172.20.57.129:  - - - - - - - - - - - - - - - - - - - - - - - - -
Client on 172.20.57.129:  [ ID] Interval           Transfer     Bandwidth       Retr
Client on 172.20.57.129:  [  4]   0.00-2.00   sec  1.86 GBytes  7.97 Gbits/sec    6             sender
Client on 172.20.57.129:  [  4]   0.00-2.00   sec  1.85 GBytes  7.93 Gbits/sec                  receiver
Client on 172.20.57.129:
Client on 172.20.57.129:  iperf Done.

deployment.apps "iperf3-server-deployment" deleted
service "iperf3-server" deleted
daemonset.apps "iperf3-clients" deleted
```

## Caution
This script could potentially disrupt normal cluster operations by causing high CPU and network load.
Use with care.

## How it works
The script will run an iperf3 client inside a pod on every cluster node including the Kubernetes master.
Each iperf3 client will then sequentially run the same benchmark against the iperf3 server running on the Kubernetes master.

All required Kubernetes resources will be created and removed after the benchmark finished successfully.

This has been tested with v1.9.6 and v1.10.0 of Kubernetes.

The latest version of this Docker image is used to run iperf3:
https://hub.docker.com/r/networkstatic/iperf3/

Details on how to use iperf3 can be found here:
https://github.com/esnet/iperf

## Thanks
Thanks to the iperf maintainers for providing such a great tool.

## License
[MIT](LICENSE)
