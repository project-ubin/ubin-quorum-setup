# Project Ubin Phase 2 - Quorum Setup

This is a repository for Project Ubin containing collection of scripts and binaries to set up a network for Quorum workstream.

# Quorum Network Setup

## A. Install Pre-requisites

1\.	Provision 14 Ubuntu (Xenial - LTS 16.04) VMs (11 banks, 1 MAS central bank, 1 MAS Regulatory Node, 1 deployment, 16GB, 2 cores)

2\.	A static IP address has to be configured for all the VMs

3\. Node v8.x.x is installed for all the VMs

4\. Npm v5.x.x is instaled for all the VMs

5\. Java 8 installed in Central Bank VM

6\.	Confirm these ports are opened in the firewall rules

```
raft-http                           TCP 40000
geth-communicationNode              TCP 50000
geth-node                           TCP 20000
DEVp2p                              TCP 30301 or 30303
constellation-network               TCP 9000
rpc                                 TCP 20010
API                                 TCP 3000
```


7\. SSH into the VM
Tip: Merge your pub key into the ~/.ssh/authorized_keys for seamless login

8\. Clone the installation setups/binaries from git repo 
https://github.com/project-ubin/ubin-quorum-setup.git, your directory structure should look like below

```sh
$ cd ~/ubin-quorum-setup
$ ls
binaries
```

9\. End any running instances of Geth and constellation instances on all the VMs

```sh
$ cd ~/ubin-quorum-setup/binaries/setup
$ ./cleanup_process.sh
```

10\. Install core prerequisites

```sh
$ cd ~/ubin-quorum-setup/binaries/setup
# Important! there is a space between the two periods

$ . ./setup_full.sh 
```

11\. Confirm installation

```sh
$ ls ubin-quorum-setup/binaries
constellation	geth
quorum-genesis	QuorumNetworkManager
setup         	
```

## B. Configure Quorum nodes using Quorum Network Manager (QNM)
Preparation for setting up new Quorum Raft network:

The VM setup for this document assumes VM nx01 is the Coordinator node and MAS Regulator node.

### 1.	Pre-requisites to be executed on all the nodes 
```sh
$ cd ~/ubin-quorum-setup/binaries/setup
$ ./cleanup_process.sh
$ ps –alef | grep geth # you should not see any geth instances running
$ ps –alef | grep constellation # you should not see any constellation instances running
$ cd ~/ubin-quorum-setup/binaries/QuorumNetworkManager

# if you are doing a re-setup and you will need to reattach to the existing screen instance
$ screen -r

# if you are doing a setup for the first time or if the screen process has been killed, execute the below
$ screen node index.js

```

### 2.	Configure coordinating node
1\. Identify the coordinator node, this is the node that all the participating nodes will join. This is the MAS Regulator node for Project Ubin - in this guide it will be named " nx01".

```sh
# Quorum Network Manager open, proceed only if ip address available.
# Type in the server name for the nodeName in the four character, this is only used for reference
# format nx01 - nx15
prompt: localIpAddress: (1.2.3.4)
prompt: nodeName: nx01
```

2\. Close any running instances of geth and constellation by selecting option 5.

```sh
prompt: nodeName: nx01
Please select an option:
1) Raft
2) QuorumChain
5) Kill all geth and constellation
prompt: option: 5
```

3\. In the menu select option 1, "Raft"

```sh
prompt: localIpAddress: (1.2.3.4)
prompt: nodeName: nx01
Please select an option:
1) Raft
2) QuorumChain
5) Kill all geth and constellation
prompt: option: 1
```

4\. Copy the IP address (this will be used when we configure the non-coordinating node)
Select 1, "Start a node as the setup coordinator"

```sh
Please select an option below:
----- Option 1 and 2 are for the initial setup of a raft network -----
1) Start a node as the setup coordinator [Ideally there should only be one coordinator]
2) Start a node as a non-coordinator
----- Option 3 is for joining a raft network post initial setup -----
3) Join a raft network if you were not part of the initial setup
4) TODO: Start whisper services and attach to already running node
5) killall geth constellation-node
0) Quit
prompt: option: 1

```

5\. Select 1, "Allow anyone to connect"

```sh
Please select an option below:
1) Allow anyone to connect
2) [TODO] Allow only people with pre-auth tokens to connect
prompt: option: 1
```

6\. Select 1, "Clear all files..."
 
```sh
Please select an option below:
1) Clear all files/configuration and start from scratch[WARNING: this clears everything]
2) Keep old files/configuration intact and start the node + whisper services
prompt: option: 1
[*] Starting new node...
Generating node key
enode: enode://b05e6feb06c36196bba57ca5e324f888b2c12f63e00503fbcc247d56f42cea2c8017cda9c90fca6381f8936582b1a5bcf3148c91891a22762665c6f33c8f0e16@52.187.61.155:20000
[*] Starting communication node...
[*] RPC connection established, Node started
Please wait for others to join. Hit any key + enter once done.
prompt: done:

```

7\. A message will appear that it is waiting for new nodes to join; at this point, participating nodes can join in. Go to Section 3 (Steps for Participating nodes (non-coordinator)) and execute the steps for each node you want to add. Return to this section and continue with the next step once you have finished adding all the new nodes.

*** Only do the next step once all the nodes have joined in ***

8\. Once all nodes have joined, press Enter to create the network config files.
Wait until all nodes have responded then press Ctrl+A+D to detach from the screen.


### 3. Steps for Participating nodes (non-coordinator)
Ensure Section 1: Pre-requisites are executed

1\.	Give the node a name (e.g. "nx02"), this name has to be unique.

```sh
prompt: localIpAddress: (1.2.3.5)
prompt: nodeName: nx02
```

2\.	Select 1, "Raft"

```sh
prompt: localIpAddress: (1.2.3.5)
prompt: nodeName: nx02
Please select an option:
1) Raft
2) QuorumChain
5) Kill all geth and constellation
prompt: option: 1
```

3\. Select 2, "Start a node as a non-coordinator"

```sh
Please select an option below:
----- Option 1 and 2 are for the initial setup of a raft network -----
1) Start a node as the setup coordinator [Ideally there should only be one coordinator]
2) Start a node as a non-coordinator
----- Option 3 is for joining a raft network post initial setup -----
3) Join a raft network if you were not part of the initial setup
4) TODO: Start whisper services and attach to already running node
5) killall geth constellation-node
0) Quit
prompt: option: 2
```

4\.	Select 1, "Clear all files..."

```sh
Please select an option below:
1) Clear all files/configuration and start from scratch[WARNING: this clears everything]
2) Keep old files/configuration intact and start the node + whisper services
prompt: option: 1
```

5\.	Enter the IP address of the coordinating node.

```sh
In order to join the network, please enter the ip address of the coordinating node
prompt: ipAddress: 1.2.3.4
```

6\.	After a short moment, a message should appear that the node has joined.

```sh
[*] Starting new node...
Account: 0xed0b370fc5d85293ed6278bfd2da15dae23f9879
Generating node key
enode: enode://0795cf843077067f740142548098dc7a01046fe9ac958984ee6ca923816e7c14ec32d98eb7816c55fcda7cd914b70bae3dca6c62063884900d7490acf40dcd7d@52.187.57.112:20000
[*] Joining communication network...
[*] RPC connection established, Node started
true
[*] Communication network joined
[*] Requesting network membership. This will block until the other node responds
[*] Network membership: ACCEPTED
[*] Requesting genesis block config. This will block until the other node is online

```

7\. The node setup is complete. Repeat the steps above for each node that will be part of the Quorum network. Detach from the screen sessions using key combos Ctrl+A+D.

8\. Confirm network setup by connecting to the geth console from within the same directory and examining the number of peers the node is connected to. The number should be total number of nodes - 1 to exclude the current node.

```sh
# if not already in this directory
$ cd ~/ubin-quorum-setup/binaries/QuorumNetworkManager
# execute script to attach to the local geth console
$ ./attachToLocalQuorumNode.sh
```

In the resulting geth console, execute command `admin.peers.length` to see the number of connected peers.

```sh
Welcome to the Geth JavaScript console!

instance: Geth/v1.5.0-unstable-f4adbc2e/linux/go1.7.3
coinbase: 0x517424387f40b6e7406ee33be7ac31700012d762
at block: 3656 (Fri, 11 Feb 47846936856 07:04:31 UTC)
 datadir: /home/azureuser/ubin-quorum-setup/binaries/QuorumNetworkManager/Blockchain
 modules: admin:1.0 debug:1.0 eth:1.0 net:1.0 personal:1.0 quorum:1.0 raft:1.0 rpc:1.0 shh:1.0 txpool:1.0 web3:1.0 zsl:1.0

> admin.peers.length
13
> 
```

9\. When all nodes have been added, return to Section 2, Step 8 to complete the network setup from the coordinator VM.


Once the coordinator steps have been completed and you have detacted from screen (Ctrl+A+D) in each of the VMs, the Raft Quorum network setup is complete.


# License

Copyright 2017 The Association of Banks in Singapore

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
