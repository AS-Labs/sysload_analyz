#!/bin/bash
lttng create my-kernel-session --output=/tmp/$(hostname)-kernel-trace
lttng list --kernel --syscall
lttng enable-event --kernel sched_switch,sched_process_fork
lttng enable-event --kernel --syscall open,close
lttng enable-event --kernel --all
lttng start
lttng destroy
