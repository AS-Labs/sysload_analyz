# sysload_analyz

### A wrapper script that continuously monitors the sysload

This Bash script is designed to monitor the system load on a periodic basis.
Generate a flamegraph if the system load exceeds a certain threshold.
The script calculates the system load and compares it to a specified threshold.
If the system load exceeds the threshold, it runs a perf trace and generates a flamegraph for analysis.


#### The Issues, and the why
- System load is ambiguous.
- If server has hung, there will be no stack trace of the kernel.
- Application logs are insufficient.
- Kernel logs do not show trace events.
- perf tool gives us details and flamegraphs lets us read the details.

#### Usage
```bash
chmod +x system_load_monitor.sh
```

Run the script:

```bash
./system_load_monitor.sh
```

### Credit
FlameGraph (http://www.brendangregg.com/flamegraphs.html).

Linux and all OSS.

### License
This script is licensed under the GNU General Public License, Version 2.
