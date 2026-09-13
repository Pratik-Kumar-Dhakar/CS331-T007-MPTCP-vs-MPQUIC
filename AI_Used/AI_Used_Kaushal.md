# Used Claude

That sounds like a lot we do not have much time ?
What i am asking is i have given the experiments to be ran they will be runn
Maybe 3 times
All i am asking when the sir asks me questions on viva and all
How do i survive that ?
I cannot run it but i can go through research papers and on the basis of what i have run in the experiments given
Cause in the end we our team only needs to understand MPTCP, MPQUIC why it is what it
What methods
What were the steps or ideas implemented why
What were the ideas why were some used or some thrown away
Like understanding it all what happened why it happened what were taken care of what were the trade offs
The above mentioned list is not limited it can be increased
Since the team has no idea on MPTCP and MPQUIC and we would like to understand it all as a beginner's point of view not the very details but an idea of what what implemented before implementing anything what was taken care of etc etc.
THE OBJECTIVE:: Is for now i need a sustainable report something which the team can read and understand in say one night and back it up any questions that might come up .
And it should not be too small or vague see the detailed project description and go oh this was present that was present.
(Not to mention in chat or any resource you create but we do not also understand much about the libraries and what is present in the libraries all the parts as in how was this setup what was taken care of why this in specific)
Along with the report we also need a pptx
Slide structure (5 slides): May extend one slide

Problem Statement & Objectives
Architecture / Mechanism — your design and how it works
Extension / Issues Fixed / Evaluation — what you built on top, bugs resolved, and results
Non-Functional Testing Parameters — performance, scalability, reliability, etc.
Challenges Faced

What works with our project give the ppt with respect to that
Before proceeding provide your understanding of the objective and work to be done with things needed to be taken care of with what will be the output and what more clarifications are required.
The project description is given below.
Project Description: Study and compare MP-QUIC and MPTCP protocols for applications like video streaming, file transfer, and VoIP, focusing on throughput, latency, and connection stability.
Tools/Technologies: QUIC implementation: quic-go, Cloudflare’s quiche MPTCP: Linux kernel MPTCP, Multipath-enabled iproute2 Network emulation: NetEm, Mininet Monitoring: iperf3, Wireshark
Expected Outcomes: Measure throughput, latency, and reliability under different network conditions Analyze how each protocol handles packet loss and congestion Gain practical experience configuring multipath protocols Provide recommendations for protocol use based on application needs

Okay — the job has changed shape. Before it was "understand deeply enough to maybe verify setups yourself." Now it's: you personally can't run anything, your teammates start from zero, and the real test is a professor firing "why" questions at you in a room. Let me lay out what I think this actually requires.

What I understand the objective to be

Two deliverables, one purpose — surviving the viva as a team that actually gets it, not one that memorized bullet points:

A single master report — not a repeat of "MPTCP exists, MP-QUIC exists," but a narrative that walks through: why multipath is a problem worth solving → how TCP's design forced MPTCP into the position it's in (subflows bolted under one kernel-level connection) → why QUIC's UDP+TLS1.3-native design made MP-QUIC possible in a fundamentally different way → what specific design choices each protocol made (scheduling, path management, congestion control coordination) and why those and not alternatives → what your specific tool stack does under the hood (quic-go/quiche internals, Linux kernel MPTCP path manager, iproute2 multipath routing, how NetEm/Mininet emulate bad networks, what iperf3/Wireshark are actually measuring) → what "throughput/latency/stability under packet loss and congestion" evaluation actually means operationally → trade-offs and discarded alternatives at each step. Written so a teammate with zero background can read it in one sitting and walk away able to answer a follow-up "why," not just recite a fact.
A 5–6 slide pptx mapped to your exact structure (Problem/Objectives → Architecture/Mechanism → Extension/Issues Fixed/Evaluation → Non-Functional Testing Parameters → Challenges) — but filled with your project's specifics (your tool stack, your three application scenarios: video/file-transfer/VoIP), not generic protocol theory.

Things I need to take care of while writing this

Depth calibration: beginner-accessible but not shallow — the "here was the problem, here was the trade-off, here's the idea that resolved it" narrative style, applied to every design decision, not just the headline ones.
Anticipate the viva-style follow-up chain ("why not X instead?", "what happens if Y fails?") rather than just stating facts — a report that only answers "what" will collapse under a second question.
Slides 3 and 4 (Evaluation, Non-Functional Testing Parameters) normally want real numbers — but your experiments haven't run yet. I need to know how to handle that gap (see below).
Keep it project-specific throughout, not a protocol textbook with your project's name stapled on.

Clarifications I need before I build this

----


No tell me the other person's part and my part i'll make sure the other person does it

Outlining acceptance criteria for the teammate's environment handoff.
Their part — environment only (Mininet/NetEm)
Hand them Phase 0 from the doc directly — the exact topology script, not "go set up Mininet" as an open-ended task. Two independently-built environments quietly disagreeing is the one failure mode you don't want here, so there's no upside to letting them freelance it from scratch.

Their job, specifically:

Install the base packages + Mininet + OVS (0.1–0.2)
Run mpquic_topo.py (0.3) — either as-is or with agreed bw/delay/loss values for whichever scenario you need first
Validate it (0.4) and hand you proof, not a verbal "it works"
What "done" actually looks like — the four things to demand, not just ask for:

sudo mn --test pingall output — 0% dropped
the topology script file itself
output of both independent-path pings (ping -I h1-eth0 ... and ping -I h1-eth1 ...) showing two distinct, correct RTTs
iperf3 baseline numbers per path matching the configured bw/delay/loss
If they can't produce those four artifacts, it isn't done — regardless of what they tell you. That's the whole of their scope for this phase; nothing about TQUIC or the actual experiments touches them.

Your part — everything from TQUIC onward
Phases 1–4: build TQUIC, run all four experiment scenarios, instrument with qlog/qvis and keylog/Wireshark, archive results, write up the analysis.

The handoff, stated plainly
Since you already have a working copy of the same script yourself, their deliverable to you isn't exclusive access to a running network — it's proof the script behaves correctly. Worth saying to them exactly that way: it reframes their task from an open-ended "set up an environment" (easy to stall on) into "run this script, paste me these four outputs" (hard to dodge, easy for you to check in thirty seconds). If their numbers match yours, great, cross-checked. If they don't, you've found a real bug before it cost you a week.

could you be more elaborate in the steps i am not aware of such stuff 
At the very least what all is present so i am now aware what an NIC is and etc etc a self sustaining doc to understand and execute both at the same time.

Created a file, ran a command, shared files
This one document has it all: Part A explains NIC/subnet/switch/socket, then walks through exactly what Mininet is doing under the hood (namespaces, veth pairs, Open vSwitch) and what NetEm actually does to a link — the concepts get referenced by name inside the code comments in Part B, so the "why" and the "what to type" sit right next to each other. Part B is your teammate's whole scope; Part C is yours, kept lighter since it leans on your other guide for the QUIC-specific theory (cwnd, schedulers, PATH_CHALLENGE) rather than re-explaining it.


Mp quic plan explained
Document·MD 
And will this practical setup cover all the cases i should be checking upon to get very correct and accurate data and will it also benchmark on all the required metrics and also what has been asked

Writing exact formulas for each performance metric.
Short answer: not yet. The plan as it stands will get you a working comparison, but it won't produce data rigorous enough to honestly claim "under different network conditions" or hold up as "accurate" — and there's one deliverable in the brief (the final recommendations) that none of the four scenarios produce by themselves. Here's the specific gap analysis, which I'm folding into the doc as a new Part D.

The core issues, briefly, before I add the detail:

Single runs aren't accurate data. netem's loss/delay is randomized — one run at loss=5% might actually see 2% or 9%. Without repeats, you can't tell real protocol behavior from one lucky/unlucky draw.
Two fixed link configs isn't "different network conditions." That phrase in the brief needs an actual swept parameter (RTT, loss, or bandwidth ratio across several values), not one fast/slow pair run once.
No explicit formulas yet for turning qlog/logs into the numbers you'll actually report (throughput, latency percentiles, recovery time).
Redundant's "2x bandwidth" claim is currently assumed, not verified against actual bytes on the wire.
No reliability/success-rate metric — given this is draft-stage software, "how often did a run even complete cleanly" is itself real data the brief's "reliability" language wants.
Mininet-specific validity traps (shared CPU, queue size vs. bandwidth-delay product) that can quietly contaminate results if unchecked.
The "recommendations by application" deliverable is a synthesis step nobody does automatically after collecting charts — it needs to be planned as its own step, not an afterthought.
Updating the file now with the concrete fixes for all of these.

Edited a file, ran a command, shared files
Same file, updated in place with Part D. The one thing I'd actually prioritize if your time gets squeezed: skip adding more scenarios before you add repetition (D.1) — three repeats of what you already have beats one run each of twice as many configurations, since right now a single unlucky netem draw could make any of your conclusions look wrong to a grader who reruns it.


Mp quic plan explained
Document·MD 

Write a message…


Claude is AI and can make mistakes. Please double-check responses.


Mp quic plan explained · MD
MP-QUIC Practical Plan — Explained From the Ground Up
This is the same plan as before, but every command now comes with a plain-language explanation of what it does and why — written so both of you can execute this without already knowing networking or Rust. This one file has everything: the concepts, their part, and your part. Hand the whole thing to your teammate; they only need Part A and Part B, but there's no harm in them seeing the rest.

For the deeper protocol theory — why QUIC/multipath is shaped the way it is, what a congestion window is, why PATH_CHALLENGE exists — that's already covered in your other guide ("The Protocol Lead's Story"). This document stays at the systems/execution level: the actual machinery you're about to type commands into.

Part A — The concepts underneath every command below
Read this once. Nothing here requires prior networking knowledge.

A.1 What a NIC actually is
A NIC (Network Interface Card) is just the "door" a computer uses to send and receive data on a network. Your laptop has at least two: a Wi-Fi NIC and an Ethernet NIC — the door exists even if you never plug in the Ethernet cable. Each NIC gets:

an IP address — its address on the network, e.g. 10.0.1.1
a MAC address — a lower-level hardware identity used by switches to deliver data within one local network. You won't touch these directly; Mininet generates them.
A computer can have several NICs at once — that's the entire premise of multipath. Your phone has a Wi-Fi NIC and a cellular NIC simultaneously; multipath transport is what lets one connection use both doors at once instead of picking just one.

A.2 Subnets, in one paragraph
10.0.1.0/24 means: every address from 10.0.1.0 to 10.0.1.255 is "the same neighborhood" — devices in that range can reach each other directly, no forwarding needed. 10.0.2.0/24 is a different neighborhood. A device sitting in both neighborhoods at once (one NIC in each) is called multihomed — exactly what your client (h1) and server (h2) are in the topology below.

A.3 Switch vs. router (why you won't need a router here)
A switch relays traffic within one neighborhood/subnet. Dumb, fast, local.
A router connects different subnets and decides how to forward between them.
The topology below uses two separate switches, two separate subnets, with both hosts sitting directly in both. Nothing ever needs to be routed between subnets — which is why nothing here mentions IP forwarding or default gateways. That omission is intentional, not something skipped.

A.4 Ports and sockets
An IP address gets you to the right building. A port number (like 8443) gets you to the right apartment — the specific program listening for connections. 10.0.1.2:8443, IP plus port together, is called a socket. When you see tquic_server -l 10.0.1.2:8443, read -l as "listen on this socket."

A.5 What Mininet is actually doing — this unlocks everything else
Mininet does not use real extra computers or real cables. Both "hosts" and both "wires" between them live inside your one real Linux machine, faked convincingly enough that ordinary, unmodified networking software can't tell the difference. Two Linux kernel features make this possible:

Network namespaces — Linux can spin up an isolated copy of "a computer's network stack" (its own interfaces, its own routing table) while still running on the same physical kernel. Each Mininet host (h1, h2) is one of these — a very lightweight virtual machine, network-wise only.
veth pairs (virtual ethernet cables) — two connected virtual interfaces; whatever goes in one end comes out the other, exactly like a physical cable, except it's pure software. When the topology script runs net.addLink(h1, s1, ...), that creates one veth pair: one end appears inside h1's namespace as a NIC called h1-eth0, the other end plugs into switch s1.
Open vSwitch (OVS) — a real, production-grade network switch implemented entirely in software, so these virtual cables have something realistic to plug into.
Put together: h1-eth0 and h1-eth1 are two genuinely independent virtual NICs, wired into two genuinely independent virtual switches. That's the whole trick behind "two paths" — two separate emulated wires standing in for what a real Wi-Fi radio and a real cellular radio would be on an actual phone.

A.6 What tc / NetEm actually does
A freshly-created veth pair has near-zero delay and zero loss — it's just a memory copy on one machine, practically instant. Useless for representing "a slow, lossy cellular link." NetEm (Network Emulation) is a real Linux kernel feature that sits on an interface and deliberately:

holds packets for extra time (delay),
drops a percentage at random (loss),
throttles how fast data can pass (rate/bandwidth),
faking exactly the imperfection a real link has. It's controlled through a tool called tc (traffic control). Mininet's TCLink, used below, is a convenience wrapper: writing bw=2, delay='100ms', loss=1 in Python is Mininet running the equivalent of tc qdisc add dev h1-eth1 netem delay 100ms loss 1% rate 2mbit for you. When your brief lists "NetEm" as a tool separate from "Mininet," this is why — NetEm is the actual kernel mechanism doing the emulation; Mininet is the layer that wires it up conveniently.

A.7 Reading a Mininet CLI session
Once the topology script reaches its CLI(net) line, you get a mininet> prompt. Typing h1 ping -c3 10.0.1.2 does not run ping on your real machine — it runs it inside h1's namespace, functionally identical to SSHing into a separate computer called h1. Every command below prefixed with a host name (h1 ..., h2 ...) works this way.

A.8 Rust/build/TLS basics (mostly relevant to Part C — your side)
Toolchain / rustup / cargo — Rust code needs a compiler (the toolchain) and a build tool. cargo is that build tool (think pip plus a build system combined); cargo build --release compiles an optimized binary.
git clone --recursive — some projects embed other git repositories as components (here: BoringSSL, an encryption library TQUIC uses for TLS). A normal clone skips those nested repos; --recursive fetches them too. Forget the flag and the build fails with a confusing missing-file error that looks unrelated to git.
TLS cert/key pair — the .crt file is a signed ID card the server shows to prove its identity; the .key file is the private half of that cryptographic pair, used to actually decrypt/sign traffic. .crt is fine to share; .key never should be (doesn't matter for this project's test certs, but it's the habit worth having).
Part B — Their part: environment setup, fully explained
Hand them this section. Everything they need is here — the commands and what each one does.

B.1 Install the base packages
bash
sudo apt update
sudo apt install -y build-essential cmake perl golang-go git mininet openvswitch-switch iperf3 tshark
What this installs and why:

mininet, openvswitch-switch — the virtual-networking tools from A.5, the actual engine behind everything in this phase.
build-essential cmake perl golang-go — not obviously networking-related, but the QUIC library (which you'll build later, in Part C) depends on an encryption library called BoringSSL, whose own build process needs Go and Perl to generate parts of itself. Missing these now causes a confusing failure two steps from now — installing them here is cheap insurance even though this machine's job is "just" the network topology.
iperf3 — a standard tool for measuring how much data a link can actually push through, used later to sanity-check that the emulated network is behaving as configured.
tshark — Wireshark's command-line counterpart, for inspecting captured traffic.
B.2 Confirm Mininet itself works before building anything
bash
sudo mn --test pingall
What this does: spins up Mininet's own default test topology, has every host ping every other host, and reports the result. You want 0% dropped. This confirms your machine can actually run the virtual-networking machinery from A.5 before you build anything custom on top of it — if this fails, nothing below will work either, and it's much easier to debug a stock test topology than your own script.

bash
sudo ip netns add test && sudo ip netns delete test
What this does: manually creates, then deletes, one network namespace (the same mechanism from A.5) — confirming your kernel/permissions allow it at all. Some locked-down VMs or containers disable this; better to find out in one line than while debugging Mininet.

B.3 The two-path topology script
This is the actual environment. Save it as mpquic_topo.py. Read the comments — they map directly back to the concepts in Part A.

python
#!/usr/bin/env python3
"""
mpquic_topo.py — reusable two-path Mininet topology for MP-QUIC experiments.

Usage:
    sudo python3 mpquic_topo.py --bw1 10 --delay1 10ms --loss1 0 \
                                 --bw2 2  --delay2 100ms --loss2 1

Drops you into the Mininet CLI once both paths are built and pinged.
Re-run with different --bw/--delay/--loss values per experiment scenario —
don't hand-edit the script per run.
"""
import argparse
from mininet.net import Mininet
from mininet.node import OVSSwitch
from mininet.link import TCLink
from mininet.cli import CLI
from mininet.log import setLogLevel


def parse_args():
    p = argparse.ArgumentParser()
    p.add_argument('--bw1', type=float, default=10, help='Mbit/s, path 1 (fast)')
    p.add_argument('--delay1', default='10ms')
    p.add_argument('--loss1', type=float, default=0)
    p.add_argument('--bw2', type=float, default=2, help='Mbit/s, path 2 (slow)')
    p.add_argument('--delay2', default='100ms')
    p.add_argument('--loss2', type=float, default=1)
    return p.parse_args()


def build(args):
    # OVSSwitch = Open vSwitch (A.5) — the software switch these virtual hosts plug into.
    # TCLink = a link type that lets us attach NetEm parameters (A.6) to each virtual cable.
    net = Mininet(switch=OVSSwitch, link=TCLink, autoSetMacs=True)

    h1 = net.addHost('h1')   # client — will end up with TWO NICs (multihomed, A.2)
    h2 = net.addHost('h2')   # server — also multihomed
    s1 = net.addSwitch('s1')  # switch for path 1's "neighborhood"
    s2 = net.addSwitch('s2')  # switch for path 2's "neighborhood" — separate from s1

    # Each addLink() call below creates one veth pair (A.5) — a genuinely separate
    # virtual cable, shaped with its own NetEm delay/loss/bandwidth (A.6).

    # Path 1: h1-eth0 <-> s1 <-> h2-eth0   (subnet 10.0.1.0/24)
    net.addLink(h1, s1, intfName1='h1-eth0', bw=args.bw1, delay=args.delay1, loss=args.loss1)
    net.addLink(h2, s1, intfName1='h2-eth0', bw=args.bw1, delay=args.delay1, loss=args.loss1)

    # Path 2: h1-eth1 <-> s2 <-> h2-eth1   (subnet 10.0.2.0/24 — a different neighborhood)
    net.addLink(h1, s2, intfName1='h1-eth1', bw=args.bw2, delay=args.delay2, loss=args.loss2)
    net.addLink(h2, s2, intfName1='h2-eth1', bw=args.bw2, delay=args.delay2, loss=args.loss2)

    net.build()   # actually creates the namespaces, veths, and switch, per A.5

    # Assign IP addresses (A.1/A.2) to each virtual NIC. Because each subnet is directly
    # attached to exactly one NIC per host, the kernel always knows which "door" to use
    # for a given destination — no router, no manual routing table entries needed (A.3).
    h1.cmd('ifconfig h1-eth0 10.0.1.1/24')
    h1.cmd('ifconfig h1-eth1 10.0.2.1/24')
    h2.cmd('ifconfig h2-eth0 10.0.1.2/24')
    h2.cmd('ifconfig h2-eth1 10.0.2.2/24')

    for sw in (s1, s2):
        sw.start([])   # brings the (software) switches online

    return net, h1, h2


if __name__ == '__main__':
    setLogLevel('info')
    args = parse_args()
    net, h1, h2 = build(args)

    print("\n--- validating path 1 (fast) ---")
    print(h1.cmd('ping -c3 -I h1-eth0 10.0.1.2'))
    print("\n--- validating path 2 (slow/lossy) ---")
    print(h1.cmd('ping -c3 -I h1-eth1 10.0.2.2'))

    CLI(net)   # drops you into the mininet> prompt from A.7
    net.stop()
Run it:

bash
sudo python3 mpquic_topo.py
(sudo is required — creating namespaces and virtual interfaces needs root privileges.)

B.4 Validate before declaring victory
You should see two ping blocks print automatically on startup — both must succeed independently, with RTTs roughly matching the configured delay (path 1 ≈10ms, path 2 ≈100ms). If one hangs, or both report the same RTT, the topology is wrong — stop and fix this before anything else, since no amount of debugging further up the stack will fix a broken network underneath it.

Once at the mininet> prompt (A.7), re-run the checks manually any time:

mininet> h1 ping -c3 -I h1-eth0 10.0.1.2     # path 1 only
mininet> h1 ping -c3 -I h1-eth1 10.0.2.2     # path 2 only
Confirm the emulated bandwidth/loss actually behaves as configured, using iperf3 (installed in B.1) — this is a plain throughput test, nothing QUIC-specific yet:

mininet> h2 iperf3 -s &
mininet> h1 iperf3 -c 10.0.1.2 -t 10 -B 10.0.1.1    # expect ~10 Mbps, ~10ms RTT
mininet> h1 iperf3 -c 10.0.2.2 -t 10 -B 10.0.2.1    # expect ~2 Mbps, ~100ms RTT, some loss
To simulate a mid-transfer path failure later (used in one of your experiments, Part C, Scenario C), from the mininet> prompt:

mininet> h1 ip link set h1-eth0 down     # kill path 1 — like a NIC losing signal
mininet> h1 ip link set h1-eth0 up       # bring it back
B.5 What "done" looks like for this part — the four things to hand back
Output of sudo mn --test pingall showing 0% dropped
The mpquic_topo.py file itself
Output of both independent-path pings (B.4), showing two distinct, correct RTTs
The iperf3 numbers per path, roughly matching the configured bw/delay/loss
If these four aren't in hand, it isn't done yet — regardless of what's said verbally.

Part C — Your part: build, run, and instrument MP-QUIC
This assumes Part A's concepts (sockets, cargo/toolchain, TLS certs) and reuses Part B's topology script directly.

C.1 Implementation choice, briefly
TQUIC (Tencent), not the quic-go/quiche named in the original brief — neither of those has multipath merged into its mainline branch as of 2026. Full reasoning and the report-methodology wording for this are in the earlier version of this plan; not repeating it here to keep this document focused.

C.2 Build
bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source "$HOME/.cargo/env"

git clone --recursive https://github.com/tencent/tquic
cd tquic
cargo build --release
ls target/release/tquic_client target/release/tquic_server   # confirm both exist
What's happening: rustup installs the Rust compiler/toolchain (A.8); --recursive pulls in BoringSSL as discussed in A.8; cargo build --release compiles the two programs you'll actually run — a client and a server — into target/release/.

Immediately after, run both with --help and keep the output nearby — TQUIC has renamed flags across versions before, so treat any flag name here as "probably right, verify against your build's actual --help."

C.3 Certs
bash
ls src/tls/testdata/   # cert.crt, cert.key — see A.8 for what these are
Use these directly; no need to generate your own yet.

C.4 Single-path sanity test — localhost first, then over Mininet
Localhost (both programs on your one real machine, no Mininet involved yet):

bash
./target/release/tquic_server -c src/tls/testdata/cert.crt -k src/tls/testdata/cert.key \
  -l 127.0.0.1:8443 --qlog-dir ./qlogs &
mkdir -p tmp
./target/release/tquic_client --connect-to 127.0.0.1:8443 https://example.org/somefile --dump-dir tmp/
(127.0.0.1 is "this machine, talking to itself" — the universal address for local-only testing, no real network hop involved.)

If this doesn't work, nothing past this point will — fix it here.

Then repeat inside the Mininet CLI, with the second path down, i.e. single-path over the emulated network from Part B:

mininet> h2 <path-to>/tquic_server -c cert.crt -k cert.key -l 10.0.1.2:8443 --qlog-dir ./qlogs &
mininet> h1 ip link set h1-eth1 down
mininet> h1 <path-to>/tquic_client --connect-to 10.0.1.2:8443 https://10.0.1.2/somefile --dump-dir tmp/
mininet> h1 ip link set h1-eth1 up
This isolates "the environment is broken" from "multipath is broken" — worth knowing which one you're looking at before debugging either.

C.5 Multipath run
bash
# server — listens on one socket (A.4)
./target/release/tquic_server -c cert.crt -k cert.key -l 10.0.1.2:8443 --qlog-dir ./qlogs

# client — binds to BOTH of its NICs' addresses (--local-addresses), telling TQUIC
# it has two independent doors (A.1) it can send out of
./target/release/tquic_client --connect-to 10.0.1.2:8443 https://10.0.1.2/somefile \
  --local-addresses 10.0.1.1,10.0.2.1 \
  --enable-multipath --multipath-algor MINRTT \
  --congestion-control-algor BBR \
  --qlog-dir ./qlogs --dump-dir ./tmp
Swap --multipath-algor between MINRTT / ROUNDROBIN / REDUNDANT for your three scheduler runs (see your other guide, Chapter 5, for what each one actually does).

Known gotcha: if only one path is ever used, check --active-cid-limit — TQUIC silently drops extra client addresses beyond its connection-ID limit. Raise it explicitly.

C.6 Experiment scenarios (unchanged from before)
Scenario A — bulk transfer, all three schedulers, asymmetric paths (maps to "file transfer" in your brief)
Scenario B — small/frequent messages, Redundant vs. single-path baseline (maps to "VoIP")
Scenario C — kill the active path mid-transfer using the command from B.4, watch for failover (maps to "video streaming"/connection stability)
Scenario D — hold the scheduler fixed, vary --loss1 and --congestion-control-algor between CUBIC and BBR (maps to "how each protocol handles packet loss and congestion")
Full parameter tables and command variants for each are in the earlier version of this plan — reuse those directly; nothing about them changes here.

C.7 Instrumentation, briefly
qlog → qvis: every run above writes qlog via --qlog-dir; drag the file into https://qvis.quictools.info/ for per-path congestion-window/RTT plots. (What qlog is and why it's formatted the way it is — JSON Text Sequences — is covered in your other guide, Chapter 6.)
SSLKEYLOGFILE → Wireshark: check --help for TQUIC's keylog flag, point Wireshark's TLS preferences at that file, filter quic, and visually confirm PATH_CHALLENGE/ PATH_RESPONSE succeeded on both paths.
iperf3: already used in B.4 to validate the topology — don't re-derive that step here, just don't skip it before blaming MP-QUIC for a topology problem.
C.8 Archiving and "done"
One folder per run (results/scenarioA_minrtt/, etc.) containing the qlog and raw client/server logs together. The bar is "succeeded at least once, with data captured" — archive a working run immediately rather than chasing a better one.

Part D — Is this actually rigorous enough? (metrics, repetition, validity)
Read this before you start collecting numbers for real, not after. Scenarios A–D get you a working comparison; this section is what turns that into data you can defend.

D.1 Gap 1 — single runs aren't accurate data, they're anecdotes
netem's loss=X% and jitter are randomized processes. One run configured at loss=5 might actually drop anywhere from 2–9% of packets over a short transfer, purely by chance. A single number from a single run doesn't tell you whether you're looking at the protocol's real behavior or one unlucky draw.

Fix — the single highest-leverage change here: run every scenario/configuration at least 3 times (5 if your time budget allows), and report mean ± range or standard deviation, not one number. This matters more than adding more scenarios.

D.2 Gap 2 — two fixed link configs isn't "different network conditions"
The brief explicitly asks for results "under different network conditions." A fast/slow pair tested once each demonstrates one comparison point, not a range. To claim this honestly, sweep at least one parameter across several values while holding the others fixed:

Sweep	Values	Varies	Fixed
RTT asymmetry	Path 2 delay = 10 / 50 / 100 / 200 ms	how different the two paths' latency is	bandwidth, loss
Loss	Path 1 loss = 0 / 1 / 5 / 10 %	congestion-signal strength	RTT, bandwidth
Bandwidth ratio	Path 2 bw = 10 / 5 / 2 / 1 Mbps (Path 1 fixed at 10)	capacity asymmetry	RTT, loss
You don't need all three at full depth given your time budget — pick the one or two that matter most (RTT sweep for Scenario A/MinRtt, loss sweep for Scenario D) and say plainly in your report that the others were held at one representative value due to time constraints. That's an honest, defensible scoping call. Silently testing one condition and calling it "different network conditions" is not.

D.3 Explicit metric formulas — what to actually extract from your logs
Metric	How to compute it	Source
Throughput / goodput	file_size_bytes / transfer_duration_s * 8 / 1e6 → Mbps	Downloaded file size (--dump-dir) + client log timestamps
Handshake latency	Time from first packet sent to connection-confirmed event	qlog connectivity events — grep your qlog for the exact event names your TQUIC version uses, they vary slightly by release
Per-message latency (Scenario B)	response_complete_time - request_sent_time, per message; report mean, p50, p95, p99 across all messages in a run	Client-side timestamps around each request
Failover recovery time (Scenario C)	Time between (last packet delivered on the killed path) and (first packet delivered on the surviving path afterward)	qlog packet_sent/packet_received events, filtered by path_id
Reliability / success rate	successful_runs / total_attempted_runs × 100, per condition	Your own run log — did the transfer complete without error or hang?
Redundant scheduler's actual overhead	(total bytes sent across both paths) / (application bytes actually delivered) — should land near 2x for Redundant, near 1x for MinRtt/RoundRobin	Sum packet_sent byte counts per path in qlog
Don't skip the last row — it's tempting to assume Redundant duplicates traffic because the docs say so. Verify it against your own qlog before writing that claim in your report.

D.4 Mininet-specific validity checks (easy to get wrong, hard to notice)
Shared CPU. All your "hosts" run on one real machine's CPU. Pushing high bandwidth, running many scenarios in parallel, or having other heavy apps open can make your results reflect your laptop's scheduler more than the protocol. Keep configured bandwidths modest (as already used above — single-to-low-double-digit Mbps), close other heavy applications while measuring, and run one configuration at a time.
Queue size vs. bandwidth-delay product. For the slow path (2 Mbps, 100 ms RTT), the bandwidth-delay product is roughly 2 Mbps × 0.1 s / 8 ≈ 25 KB. If TCLink's default queue is smaller than that, you're introducing an uncontrolled second source of loss on top of the loss= value you actually configured. Set max_queue_size explicitly on the link if you want to rule this out as a confound.
One genuine advantage: since everything runs on one machine, client and server share the exact same clock — no clock-skew concern when comparing qlog timestamps across client and server logs, unlike a real distributed deployment.
D.5 The deliverable none of the scenarios produce by themselves
"Provide recommendations for protocol use based on application needs" is a synthesis step, not a chart — budget explicit time for it after Scenarios A–D are done. Once you have repeated-run results (D.1) across your swept condition (D.2), write the paragraph that maps them back to the brief's three named applications directly: "for file transfer, use scheduler X because it measured Y Mbps vs. Z Mbps for the alternatives; for VoIP, use Redundant because p99 latency was Y ms vs. Z ms single-path; for video streaming, failover recovery averaged Y ms across N runs, acceptable/not acceptable because..." It's easy to run out of momentum after the last experiment and submit graphs without this — it's the one paragraph the brief is actually asking you to arrive at.

D.6 Updated Phase 4 checklist
 Each configuration run ≥3 times; results reported as mean ± variance, not single numbers
 At least one network parameter swept across ≥3 values (not just two fixed profiles)
 Redundant scheduler's on-wire byte count checked against the expected ~2x, not assumed
 Success rate (%) recorded across repeated connection attempts, per condition
 Queue size checked against bandwidth-delay product for the slow path
 Final "recommendation by application" section written, citing your own specific numbers
Quick glossary (everything from Part A, in one place)
Term	Plain-language meaning
NIC	The "door" a computer uses to send/receive network data; a computer can have several
IP address	A device's address on a network
Subnet	A group of addresses that can talk directly without a router
MAC address	A hardware-level identity used by switches within one subnet
Switch	Relays traffic within one subnet
Router	Forwards traffic between different subnets
Port	Identifies which program on a device a connection is for
Socket	An IP address + port together, e.g. 10.0.1.2:8443
Network namespace	Linux's way of faking "a separate computer's network stack" on one kernel
veth pair	A fake, software-only ethernet cable connecting two namespaces/interfaces
Open vSwitch	A real switch, implemented entirely in software
NetEm	The kernel feature that injects artificial delay/loss/bandwidth limits onto a link
tc	The command-line tool used to control NetEm
Toolchain / cargo	Rust's compiler and build tool
TLS cert/key	A signed identity file (cert) and its private cryptographic half (key)

---


Weighing file count against staging a confirmation check-in.
Good instinct to check before I start generating — these take real effort to get right, so let's nail the shape first.

Recommended structure: 3 focused files, not 1 giant one
The original bible split into 7 because it was building the narrative (why things happened in order). What you need now is different — a reference package you'll actually flip back to before a viva or a demo. For that, three tighter files work better than either one giant file (hard to navigate) or seven small ones (too fragmented for a "grab this and go" reference):

File 1 — MPQUIC Master Study Guide
This is the consolidated mastery document — everything from the bible's Parts 1, 2, 3, 5, 6, 7, but distilled and corrected, not just re-copied. Contents:

Standardization story (Part 1) — condensed, with today's live-checked status baked in as the current fact, not a caveat
Research lineage (Part 2) — the scheduler family tree, the packet-number-space resolution, the WiFi/Starlink worked failure example
MPTCP standalone (Part 3) — full comparison partner, since a professor will absolutely ask you to contrast the two unprompted
Why it's not mainstream (Part 5) — the six structural reasons
Decision framework (Part 6) — mapped to your three named use cases (video/file-transfer/VoIP)
Consolidated FAQ, glossary, and a viva cheat-sheet — the highest-yield Q&A pairs, including the corrections we already surfaced, written as "if asked X, say Y, and here's why"
This is the file you'd reread the morning of a viva.

File 2 — Library Comparison Deep-Dive
This is where I want to go beyond the bible, not just repeat Part 4. The bible describes each library's philosophy from documentation and blog posts. I'll pull that forward, but also actually clone TQUIC, picoquic, and quiche's source in this sandbox and read the real scheduler code, so the comparison is grounded in what the code does, not just what the docs claim. Contents:

Side-by-side scheduler architecture (how MinRtt/RoundRobin/Redundant are actually implemented in TQUIC's Rust source vs. how quiche exposes path events vs. picoquic's C4 approach)
A verified status check on quiche's multipath support (the bible flags this as "unconfirmed, in PR" — I'll check current reality)
Trade-off table: "library decides" vs "application decides" philosophies, with concrete code-level evidence for each
Practical guidance: which library to reach for depending on what you're building
This one will take a bit more work since it involves real source inspection — I'd build it right after we finish going through Part 4 together (next couple of segments).

File 3 — Hands-On Setup & Verification Guide
Directly answers your third question: yes, this is exactly where the setup-and-run instructions live. This is written entirely as steps for you to run on your own Linux machine — I won't execute any of it myself, per what we agreed. Contents:

Prerequisites (kernel version check for MPTCP, required packages)
Enabling MPTCP in the Linux kernel + iproute2 multipath route configuration
Setting up NetEm for controlled latency/loss/jitter injection
A Mininet topology definition for a repeatable two-path test environment
Building and running TQUIC and quiche client/server pairs across that topology
iperf3 measurement methodology (what to measure, how to run it fairly, common mistakes)
Wireshark capture filters and what to actually look for in a multipath capture (path IDs, PATH_CHALLENGE/RESPONSE, per-path ACKs)
A results checklist mapped back to your project's expected outcomes (throughput, latency, loss/congestion handling)
One sequencing note: File 2 will be noticeably better if I do the source-code digging before writing it — otherwise it's just a nicer-formatted version of the bible's Part 4, which isn't what you asked for. My plan is to finish the Part 3 and Part 4 teaching segments with you first (so the source-verification work also becomes something you've seen explained, not just handed a PDF of), then generate all three files together at the end with everything — including our live corrections and anything that comes up in the remaining quizzes — baked in.

Does this structure work, or would you rather I generate File 1 now (since its content is already settled) and hold 2 and 3 for later? Either way works — just say the word and I'll proceed.

If after reading these files i will be able to answer any kind of question that comes up not RFC specific but the idea of why this is implemented why this is not why QUIC has this why does not what all does it have 
All the questions which could come up ?? And that i would be able to explain my part well then proceed for now even file 1 and file 2 are enough.

Planning source-code research to ground the library comparison.
Fair question, and worth being precise about before I spend hours building these — overpromising here would waste your day.

What File 1 + File 2 will make you strong on: every "why" question that's specifically about the multipath extension — why scheduling isn't standardized, why per-path packet numbers won over shared, why TQUIC/quiche/XQUIC made different bets, why fairness isn't solved, why browsers don't have it, why MPTCP and MPQUIC trade different weaknesses, when each scheduling goal actually applies. That's the bulk of what a professor would probe on a multipath project, and after these two files you should be able to defend that territory without notes.

Where I need to flag an honest gap: the bible you uploaded constantly references "the earlier practical guide" — a document that apparently covers base QUIC fundamentals (why UDP instead of extending TCP, why the handshake merges with TLS 1.3, why streams avoid head-of-line blocking, why Connection IDs exist, why 0-RTT trades security for latency) — but that document itself wasn't uploaded here. If a question veers into "why does QUIC do X" rather than "why does multipath QUIC do X," these two files alone won't cover it as thoroughly.

Two ways to close that gap — your call:

If you have that earlier practical guide, upload it and I'll fold its specifics in directly.
If not, I'll write a self-contained "QUIC Fundamentals" primer into File 1 from scratch, using my own solid grounding in RFC 9000 — this is old, stable, settled protocol knowledge, not something that's shifted recently. That makes File 1 not depend on a document I can't see.
I'll default to (2) and proceed now, since you said go ahead — if you do have that other file handy, just drop it in later and I'll patch File 1.

One more honesty note, in the spirit of the bible's own "Honest Gaps" section: no finite document makes "any question" bulletproof. What I can promise is that File 1 will end with an explicit gaps list — the handful of things you should verify live or think through fresh rather than recite — because knowing the edges of your own knowledge is itself a strong viva move.

Now — before writing File 2, I want to actually verify it against real source rather than re-paraphrasing the bible's Part 4. Let me go pull the current code.

Ran 15 commands, read 4 files, and 5 more tools

Write a message…


Claude is AI and can make mistakes. Please double-check cited sources.

---


MPTCP_Experiments (1).xlsx
MPTCP_Experiments (1).xlsx
XLSX

Here's a full recap of the session — what's been established, produced, and what's still open. ## 1. The ask (from the project brief) Compare MP-QUIC and MPTCP for video streaming, file transfer, and VoIP — throughput, latency, connection stability, packet-loss/congestion handling — using quic-go/

pasted

Project Description: Study and compare MP-QUIC and MPTCP protocols for applications like video streaming, file transfer, and VoIP, focusing on throughput, latency, and connection stability.
Tools/Technologies: QUIC implementation: quic-go, Cloudflare’s quiche MPTCP: Linux kernel MPTCP, Multipath-enabled iproute2 Network emulation: NetEm, Mininet Monitoring: iperf3, Wireshark
Expected Outcomes: Measure throughput, latency, and reliability under different network conditions Analyze how each protocol handles packet loss and congestion Gain practical experience configuring multipath protocols Provide recommendations for protocol use based on application needs

The project description has been given above 
i kind of need to wrap it up 
from where do i study and compare 
There are multiple libaries which implement MPQUIC differently how do i compare between them understand each implementation of MPQUIC as in what is different in what and when to use one (a mental model or analogies explain it nicely)

The MPTCP has a different group working on it so how do i finalise a presentation what parts is needed to be done and asked more from the other team to experiment on 
Can you give few experiments to run on MPQUIC ?? which i can give to the group member to work on the MPTCP experiments that has been uploaded ?

What should we expect from each experiment and why and how do i run it and how do i compare with MPTCP since there are usually more factors and cases

Ran 10 commands, searched the web, read a file
I read through your uploaded MPTCP spreadsheet before answering — it changes the plan a lot for the better, so let me work through this properly.

1. Where to study/compare from (given you need to wrap up)
Don't re-read everything. Prioritize:

For the "why" defense: the narrative we already built in this session (toll-booth → badge → scheduler chain → the 12-mechanism walkthrough) is your study material. That's what survives a viva, not the dense File 1.
For library comparison: File 2, plus the corrections below (two things flagged "unconfirmed" last time are now resolved).
For hands-on setup: File 3's skeleton is still valid, but I'm revising which library to actually build against — see next section.
Skip rewriting File 1 into narrative style unless you have spare time at the end. It's redundant with what's in this chat.

2. Comparing the MPQUIC libraries — the mental model
Think of the IETF multipath draft as a traffic law that says "you may legally drive on two roads at once." Every implementation is a different manufacturer's car built to that law — and they're at very different stages:

Library	Where it actually stands	Best used for
quic-go (upstream)	No built-in multipath at all. What exists are old community forks — one is an experimental multipath extension built on top of quic-go, another is a standalone project descended from the original ETH Zürich mp-quic research code — but both predate the current draft's per-path packet-number-space design.	Historical/discussion reference only. Don't build your numbers on this.
quiche (Cloudflare)	Multipath is an open pull request adding multipath support with non-zero-length connection IDs, still targeting master and under active review — a tester who built a Mininet topology to test it reported packets landing on the wrong path's packet-number space.	Good "why hasn't this shipped yet" talking point. Usable hands-on, but budget debugging time.
TQUIC (Tencent)	Purpose-built for multipath from early releases, with experimental multipath transport support offering MinRTT and Redundant scheduling algorithms, actively maintained, Rust.	Solid hands-on candidate — native, not bolted on.
XQUIC (Alibaba)	Also native multipath, and its test harness gives you real CLI control: a flag to turn multipath on, a flag to list which interfaces/paths to use, plus reinjection and backup-path-mode flags, and a choice of congestion control algorithm per run.	Best pick for actually scripting your experiment matrix — see why below.
picoquic	Reference implementation, tracks the draft closely, used as an interop baseline by other projects.	Correctness/spec-conformance checks, not a performance harness.
msquic (Microsoft)	Confirmed no multipath, no roadmap for it.	Exclude — mention only as contrast.
Why XQUIC over the brief's named quic-go/quiche: your brief names quic-go and quiche as tools, but neither can currently give you a working multipath data point without extra engineering — quic-go has none, quiche's is an unstable in-review PR. XQUIC's -M (multipath), -i (per-path interface), -Q (backup-path mode, which maps directly to the PATH_STATUS_BACKUP mechanism we already covered), -R (reinjection), and -c (congestion control choice) give you a turnkey way to actually produce numbers before your deadline. That's a legitimate, defensible deviation — "we picked the implementation where multipath actually works reliably enough to measure, and here's the evidence for the other two" is exactly the kind of answer your professor wants.

3. The MPQUIC experiment plan (built directly into your sheet)
Your MPTCP teammate already ran a tight, well-designed protocol: E1 symmetric paths, E2 asymmetric bandwidth/delay, E3 asymmetric + loss, E4 mid-transfer path failure. That's a genuinely good experiment design — so instead of inventing a separate MPQUIC set, I mirrored it exactly (same Path 1/Path 2 bandwidth, delay, loss, duration) and added it to your workbook, plus one optional bonus:

Presented file
What's in it, per sheet:

Sheet1: added E1–E5 rows with Protocol = MP-QUIC, identical topology parameters to your teammate's MPTCP rows, and result columns marked TBD for you to fill in after running.
Expected Results: a hypothesis + mechanism-based "why" for each, written the same way your MPTCP tab is.
Observations: scaffolded rows waiting for your actual numbers.
Final Comparison: populated the MPTCP column from your teammate's real data, left the MP-QUIC column and the "Better" verdict as TBD — this is the table your presentation slide comes straight from.
Why the mirrored parameters matter: E2's expectation isn't just "Path 1 wins" — it's that MPQUIC's split comes from per-path RTT tracking and PATH_STATUS signalling rather than a coupled TCP congestion window, so the skew can legitimately come out more lopsided than MPTCP's ~91/9, and that difference is itself worth a slide. E3 is similar: loss inflates a MinRTT scheduler's RTT estimate on top of the path's already-higher delay, so Path 2 gets penalized twice. E4 is the most interesting one to present side-by-side, because the failure-detection mechanism is genuinely different (MPTCP: RTO-based subflow timeout; MPQUIC: PATH_CHALLENGE/PATH_RESPONSE probe timeout) — expect your Recovery Time numbers to not match, and that's a feature of the comparison, not noise.

E5 is optional and has no MPTCP counterpart: rerun E2's exact topology but switch XQUIC/TQUIC's scheduler (MinRTT vs Redundant). It's a cheap way to demonstrate the "scheduling is deliberately left unstandardized" point directly, which is strong material for a defend-the-why question.

4. How to actually run them
Topology — build one Mininet script and parameterize it per experiment so you're not rewriting it five times:

python
from mininet.net import Mininet
from mininet.link import TCLink
from mininet.cli import CLI

net = Mininet(link=TCLink)
h1, h2 = net.addHost('h1'), net.addHost('h2')
s1, s2 = net.addSwitch('s1'), net.addSwitch('s2')   # s1 = path 1, s2 = path 2

# Path 1 params (edit per experiment, e.g. E2: bw=50, delay='10ms')
net.addLink(h1, s1, cls=TCLink, bw=50, delay='10ms', intfName1='h1-eth0')
net.addLink(s1, h2, cls=TCLink, bw=50, delay='10ms', intfName2='h2-eth0')

# Path 2 params (e.g. E2: bw=5, delay='80ms'; E3 adds loss=3)
net.addLink(h1, s2, cls=TCLink, bw=5, delay='80ms', intfName1='h1-eth1')
net.addLink(s2, h2, cls=TCLink, bw=5, delay='80ms', intfName2='h2-eth1')

net.start()
h1.setIP('10.0.1.1/24', intf='h1-eth0'); h2.setIP('10.0.1.2/24', intf='h2-eth0')
h1.setIP('10.0.2.1/24', intf='h1-eth1'); h2.setIP('10.0.2.2/24', intf='h2-eth1')
CLI(net)
net.stop()
For E4, bring Path 2 down mid-run instead of building a new topology: h1.cmd('ip link set h1-eth1 down') at t≈30s (via a scripted sleep(30) in a CLI script, so it's reproducible).

One methodology point that matters a lot: iperf3 "just works" for MPTCP because MPTCP is kernel-transparent — regular TCP sockets, the kernel handles subflows underneath. It does not work that way for MPQUIC, since QUIC lives entirely in userspace over UDP. You need XQUIC's own test_client/test_server (or TQUIC's equivalent) to generate traffic and report stats — plain iperf3 has no idea a QUIC connection exists. This is also why Wireshark alone is a weaker tool here than it was for MPTCP: both TQUIC and XQUIC can emit qlog files, and feeding those into qvis gives you per-path RTT/loss/utilization directly, which is far less painful than reconstructing it from packet captures. Worth a line in your methodology slide explaining why the toolset had to adapt.

Example XQUIC run for E2 (asymmetric, no loss):

./test_server -a 10.0.1.2 -p 4433 -c c
./test_client -a 10.0.1.2 -p 4433 -M -i h1-eth0 -i h1-eth1 -c c -n 1 -s <bytes> -l d
(-M multipath on, -i repeated per path, -c c = cubic CC, -l d = debug logging.) Check ./test_client --help in your build for the exact current flag set before you run — options get added between releases.

5. What to ask the MPTCP team for
This is the part most likely to save you rework:

Their exact Mininet script and tc/NetEm commands — don't reconstruct these from the spreadsheet numbers; if your topology differs from theirs in some detail iperf3 wouldn't expose (queue size, MTU, htb vs tbf), the comparison quietly stops being apples-to-apples.
Which kernel MPTCP scheduler and congestion-control mode they used (default/BLEST/redundant; LIA/OLIA/BALIA) — this single fact explains their 91/9 and 97/2 splits and needs to be on the slide next to your numbers, since MPQUIC's equivalent isn't standardized the same way.
Exactly how and when they killed Path 2 in E4 (interface down? route removal? firewall drop?) — replicate the same method, not just "similar."
A pinned number instead of the ~1–3s range for E4's Recovery Time — makes the final comparison table cleaner.
Whether they'd run a fairness experiment (a single-path flow competing with the multipath flow over a shared bottleneck) — this was flagged as unresolved on both sides in our earlier session (MPTCP has LIA/OLIA/BCP 133 pointers, MPQUIC's coupled congestion control isn't standardized at all), so it's a natural joint E6 if either of you has spare time.
6. Comparing fairly, given the extra factors
Two structural differences mean "Better" isn't always a clean single winner:

Layer: MPTCP is transport-layer/kernel, transparent to the app; MPQUIC is app-layer over UDP. A throughput number for MPQUIC includes whatever overhead its userspace stack adds — that's a real, defensible difference, not measurement error.
Congestion control standardization: MPTCP's coupled CC (LIA etc.) is a settled RFC; MPQUIC's isn't standardized, so your result reflects that library's choice, not "MPQUIC" as a protocol. State the library + scheduler + CC explicitly next to every MPQUIC number.
When you fill the "Better" column, write the mechanism, not just a checkmark — e.g. "MPQUIC faster recovery in E4 because backup-path probing was pre-validated, vs. MPTCP's addition of the new subflow." That's the sentence that survives a "why" question.

7. Presentation structure
Given the professor's framing ("already covered elsewhere, so show depth"), weight it toward defense, not intro:

Motivation (brief — one slide, the toll-booth analogy)
Implementation landscape (the table above)
Shared experimental setup — emphasize both teams used the same topology
Results: E1–E5 from the Final Comparison sheet, charted
Application-specific recommendations (map E1↔file transfer, E2↔video over WiFi+cellular, E5's redundant scheduler↔VoIP)
Appendix: open questions (scheduling non-standardization, fairness, quiche/quic-go's current state) — this is where "why" questions will come from, so over-prepare it
Want me to fold the verified library-status corrections (quiche PR status, TQUIC's confirmed schedulers) back into File 2, or turn the "how to run" section above into a short doc your teammate can follow without needing this chat?


Mptcp mpquic experiments
Spreadsheet·XLSX 
could you give the experiment details so i can give it to the person to run it ?

Searched the web, created a file, shared files
Self-contained — whoever's running it doesn't need any context from this chat. It covers building XQUIC, the shared Mininet topology, exact commands per experiment (E1–E5), what to expect and why for each, how to measure every metric without needing library-specific stats, and where to put the results back in the spreadsheet from before. The one caveat flagged at the top: verify the exact CLI flags against --help on their build, since XQUIC's multipath flags are still being actively developed and could shift between releases.


Mpquic experiment instructions
Document·MD 

MPTCP: Complete Setup, Configuration, and Experimental Evaluation 1. Objective The objective of my MPTCP experiments was to evaluate how MPTCP behaves when a connection has two available network paths with different characteristics. I evaluated: Aggregate throughput Distribution of traffic between t

pasted


Background Research Report: The History Behind MPTCP and MP-QUIC Prepared for: MP-QUIC vs MPTCP: Performance and Reliability Evaluation Project Executive Summary MPTCP is a finished IETF standard (RFC 8684), it ships inside the Linux kernel, and Apple runs it in production for Siri. What actually h

pasted

Can we think of something innovative ??
What can be improved what thoughts can come up as an beginner to try and understand what possibly went wrong ?

As in ok we can try this too as an experiment 
And then in report we can say we tried this that 
I am now thinking in final MPQUIC vs MPTCP terms 

Something which we can as a team back up 
Cause the problem statement is jsut comparing 
So we need to know and either ways understand as much as possible about it.

Project Description: Study and compare MP-QUIC and MPTCP protocols for applications like video streaming, file transfer, and VoIP, focusing on throughput, latency, and connection stability.
Tools/Technologies: QUIC implementation: quic-go, Cloudflare’s quiche MPTCP: Linux kernel MPTCP, Multipath-enabled iproute2 Network emulation: NetEm, Mininet Monitoring: iperf3, Wireshark
Expected Outcomes: Measure throughput, latency, and reliability under different network conditions Analyze how each protocol handles packet loss and congestion Gain practical experience configuring multipath protocols Provide recommendations for protocol use based on application needs

Searched the web
Reading through your MPTCP report properly first: this is genuinely rigorous work — building a custom WSL2 kernel just to get real in-kernel MPTCP running is not trivial, and your teammate already caught one subtle issue themselves (flagging that "0 retransmissions" means iperf3 didn't report any, not that the network had none). That instinct is exactly the right one to build on.

Here's how I'd think about "innovative": not flashy new experiments, but the gaps that turn a comparison into a defensible piece of research. Let me give you the anchor framing first, then triage the actual additions by effort.

The framing that makes this project matter
Your background research doc already hands you this, almost by accident: the original 2017 MPQUIC vs MPTCP paper compared against MPTCP v0.91, and a later "revisit" paper found modern MPTCP (v0.92+) closes much of the gap the 2017 paper reported. Separately, a 2018 mobility study found MPQUIC's unified-connection design can actually show worse max-delay during handover than MPTCP's independent subflows, because MPQUIC has to explicitly detect a dead path before rerouting.

That's your "so what." You're not just running E1–E4 and reporting numbers — you're implicitly re-asking a 2017/2018 question with 2026 implementations: current in-kernel MPTCP v1 (RFC 8684) vs. a MPQUIC draft that's now sitting in the RFC Editor queue. Does the old finding still hold, or have both protocols matured enough to change the picture? That's a genuine research question a professor can't wave off as "already covered elsewhere," and it costs you nothing extra to frame it that way — you just need your E4 analysis to explicitly engage with it (see Tier 2 below).

Tier 1 — cheap, do these, they close real gaps
1. Match the MPTCP team's topology approach, not Mininet. Your teammate explicitly noted Mininet was installed but abandoned in favor of raw network namespaces + veth pairs for the actual experiments — almost certainly a WSL2/OVS friction issue. That's a perfectly good "why" answer if someone asks, but it also means: if the MPQUIC side runs on native Linux + Mininet while the MPTCP side ran on WSL2 + raw netns, you've introduced a second variable (different kernel network stack, different host) on top of the protocol difference you're actually trying to isolate. Since XQUIC's test tools just bind to IP addresses, the exact same mptcp-client/mptcp-server namespace-and-veth pattern (even reusing 10.0.1.x/10.0.2.x) works for MPQUIC too — and ideally, run both sets on the same physical machine. This is a five-minute change that meaningfully strengthens "the comparison is fair."

2. Add single-path baselines. Right now every MPTCP number is "MPTCP over 2 paths" with nothing to compare it against except itself. Run the same topology once with only Path 1's interface up and plain TCP (no -m) — this is exactly what the 2017 De Coninck/Bonaventure paper did (single-path TCP, single-path QUIC, MPTCP, MPQUIC, all four, head-to-head). Without it you're assuming multipath helps; with it you can actually show the number.

3. Check the MPTCP-level retransmission counter, not just iperf3's. This is the most interesting thing I noticed. iperf3's retransmission count is a TCP-socket-level stat. The kernel separately tracks a distinct MPTCP-level counter for segments retransmitted at the MPTCP layer, exposed through the same netstat-style interface that nstat and netstat -s already read kernel counters from. That means your "0 retransmissions" in E3 (3% loss on Path 2!) could still be hiding real recovery activity — MPTCP can silently re-send lost data on the other subflow (reinjection) without it ever showing up as a same-subflow TCP retransmission. Run this immediately before/after each test: 
Linux kernel mirror (for testing) git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git +2

nstat -az > before.txt
# ...run the iperf3 test...
nstat -az > after.txt
diff before.txt after.txt | grep -i mptcp
Look at MPTcpExtRetransSegs and MPTcpExtDSSNoMatch specifically. If those are non-zero while iperf3 says 0, that's a genuinely good finding for the report — "loss on Path 2 was actually happening, MPTCP was just recovering it invisibly via reinjection onto Path 1" is a much better sentence than "no retransmissions occurred."

4. Repeat each run 3–5 times. Right now every result is Run = 1. A mean ± range across repeats is a one-line change to your run script and immediately answers the inevitable "how do you know that wasn't a fluke?" question.

5. Grab one Wireshark screenshot per protocol. Your brief names Wireshark explicitly but the actual methodology relies on tcpdump + counters. Take one E1 capture, open it in Wireshark, filter tcp.options.mptcp, and screenshot the MP_CAPABLE/MP_JOIN handshake. Do the equivalent for MPQUIC (export SSLKEYLOGFILE so the QUIC dissector can decrypt, then show the transport parameters / path negotiation). Cheap, and it's the single most visually convincing slide you can produce — "here's the protocol mechanism actually happening," not just a throughput bar chart.

Tier 2 — good payoff if you have a day left
6. Re-read E4 for max-delay spike, not just recovery time. You already have the data collection method (live 1-second tshark/interface-counter sampling). Instead of only reporting "throughput recovered in ~1–3s," also report the single worst per-second delay/drop during the transition. This is the exact metric the 2018 mobility paper flagged as MPQUIC's weak spot — so whichever way it comes out, you get to say something specific: either "we replicate the 2018 finding" or "modern MPQUIC's path validation has closed this gap" — both are good sentences for a defense.

7. Check sysctl net.mptcp.available_schedulers on your custom kernel. The kernel supports selecting between schedulers via a per-namespace sysctl, defaulting to "default". If your build has more than the default compiled in, running E2 again with a different scheduler mirrors the MPQUIC-side scheduler experiment (E5) I set up earlier — same topology, only the scheduler changes, on both protocols. If nothing else is available, that's fine too — just note it as a limitation rather than silently skipping it. 
googlesource
hust

8. Add one application-shaped traffic test, and pair it with a written point, not just a number. Real VoIP normally avoids TCP entirely, because TCP's in-order reliable delivery adds retransmission-induced delay that hurts real-time audio worse than an occasional dropped packet would. MPTCP is structurally TCP, so it can't offer unreliable/unordered delivery the way real VoIP wants. QUIC's DATAGRAM extension can. That's a genuine, citable design-level answer to "why would you pick one over the other for VoIP" — you don't even need a perfect experiment to make the point, though a low-bitrate paced iperf3 run (-b 64k) measuring jitter on both sides adds a number to back it up.

Tier 3 — mention as "future work," probably skip given your timeline
A real shared-bottleneck fairness test (multipath flow competing with a plain single-path flow) — ties to the LIA/OLIA fairness question your own research doc raises, but it's a new topology, not a tweak of an existing one.
CPU-contention check (mpstat during runs) as a footnote on measurement validity.
For the actual "final MPQUIC vs MPTCP" slide: resist making it a single winner. Your own research doc already gives you the nuanced version — MPQUIC wins on loss tolerance and avoids the middlebox problem that capped MPTCP's real-world reach, but MPTCP's independent subflows can still out-perform MPQUIC's unified connection on handover delay in some patterns. "It depends on the failure mode and the application" is a more defensible thesis than "MPQUIC is better," and it's the one your evidence actually supports.

Want me to fold the ones you pick into the instructions doc and spreadsheet from before, or leave those as-is and just work through this as a checklist with your teammate first?


Write a message…


Claude is AI and can make mistakes. Please double-check cited sources.


---



A change in plan 
Ok the base remains the same i should be able to understand what is QUIC why MPQUIC and all
The thing is I want to say read some research papers go through what some libraries have been implementing 
Compare those
Why MPQUIC is not yet mainstream what issues were there what innovations ideas the complete theoretical guide as to say this is what is basically MPQUIC now various libraries aproach this idea differently 
What those idea are what are the typical use cases of MPQUIC when to use it. Comparing 
Then i can recreate those simulations maybe improvise a little from my end ?

Ask and provide all that you are initially planning to make a brief of what i will be getting.

Searched the web
Good — I did some digging before answering so this brief is grounded in what's actually out there right now, not just recall. Quick honest note: the standardization picture has moved since the theory doc I gave you earlier called it "still a draft, not an RFC" — as of March 2026 it's draft-ietf-quic-multipath-21, and it's already been sitting with the IESG waiting for final Area Director go-ahead since January. It's genuinely close to becoming an RFC now, which is a more interesting "why isn't this mainstream yet" story than "it's an early draft."

Here's what I found and what the guide would cover:

The standardization thread — how draft-liu-multipath-quic and Huitema's competing draft-huitema-quic-mpath-explicit got merged into one WG draft, what it deliberately does and doesn't specify (it standardizes path IDs and path lifecycle, but explicitly says "there are currently no IETF specifications that define scheduling algorithms" — that gap is why every library does scheduling differently).

The research lineage — the actual paper trail: De Coninck & Bonaventure's original "Multipath QUIC: Design and Evaluation" (CoNEXT 2017, the academic prototype every later work builds on), De Coninck's "Packet Number Space Debate" paper (a real, still-unresolved implementation-choice tension between libraries), and Huitema's picoquic blog series documenting the actual corner cases he hit (0-RTT with multipath, key rotation across paths, NAT traversal) plus his new C4 congestion-control algorithm built specifically for multipath.

The scheduler zoo — MinRtt was never the end of the story. There's a whole lineage: BLEST → ECF → Peekaboo (reinforcement learning) → Q-ReLeS / RELES / FALCON / BLP / SA-ECF / Chorus (video-QoE-aware) → DRL actor-critic schedulers for 5G/vehicular IoT. Each paper exists because it found a specific failure mode in the previous one (mostly: head-of-line blocking from naively trusting a slow path).

Library comparison — TQUIC (fixed enum of 3 schedulers, decided by the library) vs. Cloudflare's quiche (deliberately exposes path events to the application and lets it decide — an actual philosophical fork visible in their GitHub PR discussion) vs. picoquic (Huitema's from-scratch implementation, used to pressure-test the draft itself). I'd want to check ngtcp2/msquic/lsquic status too before claiming anything there.

Why not mainstream — no standard scheduler yet (fragmentation), inconsistent OS/NIC-level UDP offload support, no cross-platform way for a QUIC library to even ask the OS "what interfaces do I have," the chicken-and-egg deployment problem, and a security surface (path-validation amplification risk) that's smaller than MPTCP's but not zero.

Use-case framework — when MPQUIC actually beats plain QUIC or MPTCP, and when it's not worth the complexity.

Before I write this up properly —

What format should the final guide take?
Narrative story-style (like the earlier doc)
Should MPTCP comparisons be woven in throughout, or kept out (separate doc)?
Weave it in but also explain it atleast briefly so it's not just blank that ok it exists
Include a forward-looking section on implementing/improvising your own scheduler in TQUIC?
For now just this comparison and all is enough do not add the implementation part for now
Drafting a narrative explanation weaving in MPTCP details.
Drafting a narrative explanation weaving in MPTCP details.
I need to compare these libraries and all 
This overall can be a research level work can you just guide me out properly as to what should i be doing and what all should i be knowing 

I will be treating this guide as bible so make it contain almost everything i will need or require and where i might not at the start or end and mentioning. 

It might be a very big file so you can berak it into parts and then into different files or append it part by part to the same file

Searched the web
This is going to be substantial — treating it as a proper reference work rather than a single essay. Here's the shape I'm building, then I'll start writing it part by part.

The Bible, in 8 parts:

Part 0 — How to use this, and an honest map of what it does/doesn't cover
Part 1 — The standardization story: why multipath was deferred, how the competing drafts merged, exactly where the spec stands today (it's closer to becoming an RFC than you'd think)
Part 2 — The research lineage: CoNEXT'17 origin paper → the packet-number-space debate → the scheduler family tree (BLEST, ECF, Peekaboo, and why each was invented) → what's happening in 2025-2026 papers
Part 3 — MPTCP primer, standalone: LIA/OLIA/BALIA, Apple's Siri deployment, its own scheduler history — the direct ancestor of everything in Part 2
Part 4 — Library-by-library comparison: TQUIC, picoquic, Cloudflare's quiche, Alibaba's XQUIC, the quic-go multipath forks — and who's explicitly not supporting it (msquic, mainline quic-go)
Part 5 — Why it's still not mainstream, even this close to RFC
Part 6 — Decision framework: when to actually reach for this
Part 7 — Consolidated FAQ, glossary, full bibliography, and an honest gaps section
Writing Parts 0–2 now.

Created 3 files, shared files
First three parts are up. Quick status check before I keep going:

Done — Parts 0, 1, 2:

Part 0: how to use the bible, reading order, and an honest "what this doesn't cover" section
Part 1: the full standardization story — the pre-IETF 2017 academic prototype, the three competing drafts merging into one, and exactly where the spec stands today (it's at draft-21, already submitted to the IESG and waiting on final AD go-ahead — much closer to becoming an RFC than "still a draft" suggests)
Part 2: the research lineage — the founding CoNEXT'17 paper, the still-unresolved packet-number-space debate, Huitema's picoquic implementation diary (what actually breaks when you build this), his C4 congestion-control work, the full scheduler family tree (BLEST → ECF → learning-based → production/QoE-aware), and a concrete 2026 worked example of MinRTT actively backfiring on real-time video
Still coming — Parts 3–7:

Part 3: MPTCP primer, standalone (LIA/OLIA/BALIA, Apple's Siri deployment, its own scheduler lineage)
Part 4: library-by-library comparison — TQUIC, picoquic, quiche, XQUIC, the quic-go multipath forks, and who's explicitly not supporting it (msquic, mainline quic-go)
Part 5: why it's not mainstream yet, structurally
Part 6: decision framework — when to actually use it
Part 7: consolidated FAQ, glossary, full bibliography, honest gaps
Continuing straight into Part 3 now.

Created 5 files, searched the web, shared files
That's the full bible — all 8 parts, done in one pass:

Part 0 — how to use it, reading order, honest scope disclaimer
Part 1 — the standardization story, ending with exactly where the draft stands right now (submitted to the IESG, waiting on final AD go-ahead — check the Datatracker yourself before your viva, it may have moved further)
Part 2 — the research lineage: founding paper → packet-number-space debate → picoquic's implementation diary → the full scheduler family tree → a concrete 2026 worked example of a scheduler backfiring
Part 3 — MPTCP standalone: LIA/OLIA/BALIA, Apple's Siri deployment, its own scheduler history (the direct ancestor of Part 2's tree)
Part 4 — library-by-library: TQUIC, picoquic, quiche, XQUIC, the quic-go fork lineage, plus confirmed non-support in msquic, mainline quic-go, and lsquic
Part 5 — six structural reasons it's still not mainstream, even this close to RFC
Part 6 — decision framework mapped directly to your project's three application categories (video streaming, file transfer, VoIP)
Part 7 — consolidated FAQ, glossary, full bibliography, and an honest "verify this yourself" section
A few things worth knowing about how I built this: every part is grounded in sources I actually searched and read during this conversation (drafts on the IETF Datatracker, GitHub repos/issues/PRs, and papers from 2016 through 2026), not recalled from memory — which matters here since this field moved a lot even within my training cutoff-to-now gap. Part 7's §7.4 flags the specific spots where I couldn't fully confirm something (quiche's merge status, ngtcp2's status) rather than papering over it.

Read Part 0 first, then 1→2 in order since they're chronological. Parts 3–6 can be read in any order after that. Let me know if you want me to adjust depth anywhere, or if you're ready to move toward picking one scheduler idea from Part 2 to actually build later.


Mpquic bible part0 overview
Document·MD 

Mpquic bible part1 standardization story
Document·MD 

Mpquic bible part2 research lineage
Document·MD 

Mpquic bible part3 mptcp primer
Document·MD 

Mpquic bible part4 library comparison
Document·MD 

Mpquic bible part5 why not mainstream
Document·MD 

Mpquic bible part6 decision framework
Document·MD 

Mpquic bible part7 faq glossary bibliography
Document·MD 


Write a message…


Claude is AI and can make mistakes. Please double-check cited sources.


---



# Protocol Lead — Aug 31 → Sep 1 Guide Calibrated to: Linux environment ready and tested, very comfortable with the command line, zero prior networking background. That means no time spent on environment hand-holding — it all goes into fundamentals (where you actually need it) and the TQUIC build/t

pasted


# MP-QUIC vs MPTCP — Final Execution Plan (Aug 29 → Sep 10) Team of 4. No live demo required — only a viva/presentation (and a short report). That changes the engineering bar: the goal isn't a bulletproof, always-works pipeline, it's **real data captured at least once, and every person able to expl

pasted

I am working on this project  I have completed the september 1 part in the protocol lead part I had talks with my prof and he says what the project actually is that we have tried multipath and we had MPTCP and MPQUIC now the MPTCP failed years ago but the MPQUIC is being worked on currently  We need to understand what it is why it is how it handles everything  We need to benchmark like ok this is the throughput and all mentioned in the file  Now we need to understand the project that is the main key understand each and every part of it the theoretical aspect of it  Could you explain to me the flow of this project from here and also  Could you tell me what should be my steps for September 2 i think we will go with TQUIC plan A i have done the setup so it should be fine also like if i had the understanding of what is going on i can maybe work on it and improve it or at some place i feel it can be improved by doing some other way that way i can improve so.  My team needs to have the understanding as to what is being done whhy is it being done obviously multipath is better and faster but why has it not been in general use yet etc etc all the possible questions so i do not have blind spots when sir asks me viva in this topic.

Searched the web
Good news: your professor's reframe isn't actually a scope change — it's exactly the bar your own plan already set ("nobody puts a claim on a slide unless they can explain what's happening at the protocol level"). You're not behind; you're being asked to actually hit the target the plan wrote for you. Let me walk through where you are, what Sep 2 needs from you specifically, and then go deep on the "why" questions so you don't have blind spots.

Where the project flow goes from here
You're the Protocol Lead, so here's your thread through the plan:

Sep 1 (done): go/no-go — sounds like Plan A (TQUIC/MP-QUIC) is confirmed.
Sep 2–3: Trial matrix. Your job — run the scheduling comparison (MinRTT / Redundant / RoundRobin) across the team's agreed netem conditions, prediction-before-run each time. This is the actual data collection phase.
Sep 4: Verification. qlog analysis — per-path congestion windows, decrypting a handshake via SSLKEYLOGFILE to look at what's actually negotiated.
Sep 5–7: Write-up + consolidation. You write the scheduling-comparison and congestion-control sections, build the shared FAQ, review the whole report for unexplained claims.
Sep 8 & 10: Two mock vivas, with a gap-fixing day between them.
So "from here" concretely means: today you stop proving TQUIC can run, and start proving it behaves differently under different scheduler/condition combinations — with a prediction on record before you know the answer.

Sep 2 — your concrete steps
One important thing to flag before the list: your Sep 1 test used two loopback addresses (127.0.0.1/127.0.0.2). Those have essentially identical RTT and bandwidth — so MinRTT, RoundRobin, and Redundant have no real difference to react to yet. Today's trial matrix only means something once you're running over your team's actual asymmetric Mininet/netem paths.

Sync with Experiment Ops on real path conditions
Get the finalized Mininet topology and the 3 netem conditions (latency/bandwidth/loss asymmetry) they built Aug 29-31. This replaces your Sep 1 loopback setup — schedulers can't show meaningfully different behavior until the two paths actually differ.
1
2
3
4
5
6
7
Now the theory — so there are no blind spots
Here's the architectural difference that everything else follows from:

V

Connecting to visualize...
MPTCP glues two whole TCP connections together inside the kernel, coupling their congestion windows so the pair behaves like one fair flow (that coupling is exactly what LIA/OLIA/BALIA compute, and exactly what your MPTCP Lead's fairness demo is testing). MP-QUIC instead keeps one connection identity and opens multiple paths under it — the mechanism is closer to "connection migration, but simultaneous instead of sequential" than to "two connections stapled together."

Why hasn't either one become the default way the internet connects — and why is your professor right that MP-QUIC is specifically "being worked on" right now?

MPTCP genuinely is deployed — Apple has shipped it on every iPhone since iOS 7 in 2013 for Siri, Music, Maps, and Wi-Fi Assist, making it the first large-scale commercial MPTCP deployment, and Linux has had it in-kernel since version 5.6, with network operators like Korea Telecom and Yelcot Telecom using it commercially. But look at the pattern: every real deployment is a company controlling both endpoints — Apple's phone talking to Apple's servers, a telco's proxy talking to its own subscribers. It never became "your browser transparently multipaths to any website," partly because it needs kernel support on both ends, and partly because MPTCP's signaling rides in plaintext TCP options that ordinary middleboxes (NATs, firewalls) routinely strip or mangle. 
DEV Community
APNIC Blog

MP-QUIC is earlier on the same curve. The spec itself is still moving — draft-ietf-quic-multipath is on revision 21 as of March 2026 and still explicitly not an RFC — so browsers (which only ship finished, cross-vendor-agreed extensions) have nothing stable to implement yet. But it's not vaporware either: the same standardization effort has Alibaba and Uber engineers as co-editors, and Alibaba has already run a QoE-driven multipath QUIC system in production inside Taobao's short-video product, reporting real reductions in tail latency and rebuffering. That's the honest viva answer: MP-QUIC is roughly where MPTCP was around 2012–13 — vertically-integrated companies who own both endpoints are already shipping it and winning, but it isn't a finished, browser-default internet standard yet. Your own scheduler comparison is quite literally part of the open research that has to happen before it can become one. 
arXiv

Where you could genuinely push the project further
A few directions that are real extensions, not busywork, now that you understand the mechanism:

Test the SPNS vs MPNS question — whether MP-QUIC should use one shared packet-number space or one per path is an open point in the draft itself; Alibaba engineers ran exactly this experiment. TQUIC's default choice is worth stating explicitly and, if time allows, poking at.
Pair your scheduler comparison with the MPTCP fairness demo directly — run both protocols under the same netem conditions and show, side by side, throughput-with-coupling vs throughput-without (MP-QUIC has no standardized congestion-control coupling yet — that gap is itself a good slide).
Add a latency-sensitive profile alongside your bulk-transfer one — Redundant scheduling's whole argument is about tail latency, not throughput; a small-message/high-frequency test is where it should visibly win and MinRTT should visibly lose.
I've put the full deep-dive — MPTCP/MP-QUIC mechanics, the "why not mainstream" case with sources, a straight comparison table, the three schedulers in depth, and about 15 likely viva Q&As — into a reference doc below. That's meant to double as your team's Shared FAQ deliverable; have everyone read it and add their own "why" questions as they hit them.

Created a file, shared files
That doc has everything above plus the full comparison table, the scheduler deep-dive, and ~15 viva Q&As — share it with the team as the Sep 1 entry into your Shared FAQ, and have each person add their own "why" question as they hit one while writing their section, per your plan's understanding-verification system.

One thing worth doing today before you dive into the trial matrix: walk the "why hasn't this reached general use" answer out loud to your team once, unscripted. It's the single question most likely to come up cold in the viva, and it's the one your professor just told you is the actual point of the project — worth making sure everyone can say it in their own words, not just read it off the doc.


Mpquic vs mptcp understanding and viva prep
Document·MD 

Write a message…


Claude is AI and can make mistakes. Please double-check cited sources.


---


project6_mpquic_vs_mptcp.md
project6_mpquic
_vs_mptcp
.md
MD
This is my project idea and analysis 
The main idea is 
Multi-Path QUIC (MP-QUIC) vs MPTCP: Performance and Reliability Evaluation
Project Description: Study and compare MP-QUIC and MPTCP protocols for applications like video streaming, file transfer, and VoIP, focusing on throughput, latency, and connection stability.

Tools/Technologies:
QUIC implementation: quic-go, Cloudflare’s quiche
MPTCP: Linux kernel MPTCP, Multipath-enabled iproute2
Network emulation: NetEm, Mininet
Monitoring: iperf3, Wireshark

Expected Outcomes:
Measure throughput, latency, and reliability under different network conditions
Analyze how each protocol handles packet loss and congestion
Gain practical experience configuring multipath protocols
Provide recommendations for protocol use based on application needs

I have a team of 4 with ability (to learn as quick as possible) say 
What needs to happen is we need to complete this before 11th of september And i need to break this whole work into the 4 people and we all have no clue of this project so something remarkable 
The instructor wants to see our understanding of this project the complete understanding what we have understood and he might ask questions about each and every minor stuff (i also not want to completely rely on them for the understanding part so i will have to do it all the high one is me again do not mention the ranking anywhere) 
Create a complete detailed plan as to what needs to happen when and in what order and what stuff can i trust them with so i can start the work distribution and get done with the project. ?

# MP-QUIC vs MPTCP — Final Execution Plan (Aug 29 → Sep 10)

**Team of 4. Deliverables: viva/presentation + short report. No live demo required.**

That last point matters more than it looks: the bar isn't "a bulletproof pipeline that works on command," it's **real data captured at least once, and every person on the team able to explain what it means.** Build the plan around that, and the rest falls into place.

---

## 1. How the work is split, and why

We split by **which thread of the project each piece of work naturally belongs to**, not by who happens to be available when. Each role owns one continuous thread end-to-end — setup through data through explanation — so nobody is context-switching between unrelated parts of the stack, and nobody has to hand off half-finished work to someone else mid-week.

| Role | Owns | Why this grouping |
|---|---|---|
| **Protocol Lead** | MP-QUIC / TQUIC: build, scheduler trials, qlog analysis | Whoever gets the TQUIC build running first should carry it through the scheduler comparison — the mental model of *why* MinRTT/Redundant/RoundRobin behave differently only holds together if it's built in one head, not relayed secondhand partway through. |
| **MPTCP Lead** | MPTCP: kernel config, fairness experiments, packet capture | Same logic on the other protocol — one continuous owner from `sysctl` config through to explaining the MP_CAPABLE handshake. |
| **Experiment Operations** | Mininet topology, netem conditions, running the trial matrix, logging | This is the shared infrastructure both protocol threads run on top of — it needs to be built once, correctly, and reused by both leads rather than each of them rebuilding their own. Centralizing it here also means there's exactly one topology to defend in the viva, not two subtly different ones. |
| **Data & Presentation** | Consolidating results, plotting, slide/report assembly, formatting | This role starts light and gets heavier as real numbers come in from the other three — it's the natural place for that ramp to live, rather than splitting it thinly across everyone and having no one own the final output end-to-end. |

**The one rule that overrides all of this:** nobody puts a graph or a bullet point on a slide unless they can explain what's happening underneath it. If a person can't explain their own slide, it gets cut or reassigned before the mock viva — not during the real one.

---

## 2. Timeline

### Phase 1 — Setup & Go/No-Go (Aug 29 – Sep 1)

**Aug 29–30**
- Protocol Lead: install Rust/cargo, clone TQUIC, get `tquic_client`/`tquic_server` building. Run a localhost sanity test (no Mininet yet).
- MPTCP Lead: confirm kernel MPTCP support (`sysctl net.mptcp.enabled`), get `ip mptcp` / iproute2 multipath working on two loopback-style interfaces.
- Experiment Operations: install Mininet + Open vSwitch, run `sudo mn --test pingall`, confirm 0% dropped. Draft the two-path topology script (parameterized bandwidth/delay/loss, not hardcoded per experiment).
- Data & Presentation: set up the shared results spreadsheet (columns for experiment ID, condition, protocol, metric, value, run number) and the slide/report skeleton so everyone drops data into the same structure from day one.

**Sep 1 — Hard deadline: Go/No-Go on TQUIC**
This date does not move. If TQUIC isn't producing *any* usable output by end of day, the team pivots immediately (e.g. to picoquic or XQUIC) rather than losing another week discovering it later. Protocol Lead reports status; whole team present for the decision since it affects everyone's downstream timeline.

### Phase 2 — Trial Matrix (Sep 2 – Sep 3)

- Experiment Operations hands off the finalized topology + 3 netem conditions (symmetric, asymmetric bandwidth/delay, asymmetric + loss) to both leads.
- Protocol Lead runs the MP-QUIC scheduler comparison (MinRTT / Redundant / RoundRobin) across all 3 conditions. **Predict the expected result before each run, write it down, then compare against what actually happened** — a mismatch between prediction and result is often the most interesting thing to explain in the viva.
- MPTCP Lead runs the equivalent MPTCP experiments (including the fairness test) across the same 3 conditions, using the same topology.
- Every run logged to the shared spreadsheet immediately, not batched at the end of the day.

### Phase 3 — Verification (Sep 4)

- Protocol Lead: qlog analysis via qvis — per-path congestion window, RTT, and confirm what the Redundant scheduler is actually doing on the wire (byte overhead should land near 2x).
- MPTCP Lead: packet capture review — confirm MP_CAPABLE/MP_JOIN handshake, check MPTCP-level retransmission counters (`nstat -az`) against iperf3's counters to catch retransmissions iperf3 alone wouldn't show.
- Experiment Operations: sanity-check the topology itself — queue size vs. bandwidth-delay product on the slow path, confirm configured netem values match what iperf3 actually measures.
- Data & Presentation: first full pass at charts from whatever data exists so gaps are visible now, not on Sep 7.

### Phase 4 — Write-up & Consolidation (Sep 5 – Sep 7)

- Protocol Lead + MPTCP Lead each write the mechanism-level explanation section for their own results — not just "throughput was X," but *why* it was X.
- Everyone contributes to a **shared FAQ**: as each person writes their section, any "why" question they had to look up gets added to the FAQ so the rest of the team doesn't hit the same gap cold in the viva.
- Data & Presentation consolidates everything into the final slide deck and report draft.
- **Sep 6 — optional early-showing slot.** If the deck and data are in reasonable shape, this is the point to show the instructor progress ahead of the final date. Not mandatory, but worth taking if ready — earlier feedback is cheaper to act on than late feedback.

### Phase 5 — Mock Vivas (Sep 8 & Sep 10)

- **Sep 8 — Mock viva #1.** Each person is questioned on their own section *and* at least one other section, cold. Anyone who freezes or can't explain a slide flags exactly what needs fixing before Sep 10 — that's the point of running it now instead of finding out live.
- **Sep 9 — Gap-fixing day.** Fix whatever the mock viva exposed: weak explanations, missing data, unclear slides.
- **Sep 10 — Mock viva #2 (final check) / submission-ready.**
- **Sep 11 — Buffer.** Untouched unless something on Sep 10 needs one more pass.

---

## 3. What "done" looks like per role

- **Protocol Lead:** MP-QUIC data across all 3 conditions × 3 schedulers, qlog-verified, mechanism explained for each.
- **MPTCP Lead:** MPTCP data across the same 3 conditions, fairness result included, handshake and retransmission behavior explained.
- **Experiment Operations:** one topology script, reused by both leads, with validation artifacts (pingall output, per-path RTT, iperf3 baseline) proving it behaves as configured.
- **Data & Presentation:** final deck mapped to the 5-slide structure (Problem/Objectives → Architecture/Mechanism → Evaluation → Non-Functional Parameters → Challenges), report drafted, shared FAQ compiled from everyone's contributions.

The team-wide finish line isn't "the slides look good" — it's **every person can take any slide in the deck, not just their own, and explain what's happening on it.**


