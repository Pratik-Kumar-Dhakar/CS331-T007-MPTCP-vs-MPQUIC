# MPTCP Setup & Verification

This directory contains scripts and notes for setting up and verifying the Linux MPTCP environment used in the **MP-QUIC vs MPTCP** project.

## Requirements

* Linux kernel **5.6+**
* `iproute2` with MPTCP support
* `sudo` privileges
* MPTCP enabled in the kernel

Our current reference environment:

```text
Kernel:    6.8.0-106-generic
iproute2: 5.15.0
MPTCP:     enabled
```

## Verify MPTCP Support

Check the kernel version:

```bash
uname -r
```

Check whether MPTCP is available:

```bash
cat /proc/sys/net/mptcp/enabled
```

Expected:

```text
1
```

You can also check using:

```bash
sysctl net.mptcp.enabled
```

Expected:

```text
net.mptcp.enabled = 1
```

## Enable MPTCP

If MPTCP is available but disabled:

```bash
sudo sysctl -w net.mptcp.enabled=1
```

Verify:

```bash
cat /proc/sys/net/mptcp/enabled
```

## Verify iproute2

Check the installed version:

```bash
ip -V
```

Check that MPTCP commands are available:

```bash
ip mptcp
```

The command should display MPTCP subcommands such as:

```text
ip mptcp endpoint
ip mptcp limits
ip mptcp monitor
```

## Check MPTCP Configuration

View MPTCP limits:

```bash
sudo ip mptcp limits
```

View configured endpoints:

```bash
sudo ip mptcp endpoint show
```

View MPTCP sockets:

```bash
ss -M
```

An empty result from `ss -M` is normal when no MPTCP connection is currently active.

Similarly, no endpoints may be shown before additional MPTCP paths are configured.

## Monitor MPTCP Events

Run:

```bash
sudo ip mptcp monitor
```

The monitor waits for MPTCP events.

Stop it with:

```text
Ctrl+C
```

Running the monitor without `sudo` may result in:

```text
can't subscribe to mptcp events: Operation not permitted
```

This does not necessarily indicate a problem with MPTCP. Use `sudo`.

## Automated Check

The `check-mptcp.sh` script performs the basic environment checks automatically.

From the project root:

```bash
./scripts/mptcp/check-mptcp.sh
```

If necessary, make it executable:

```bash
chmod +x scripts/mptcp/check-mptcp.sh
```
