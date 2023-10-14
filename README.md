# sysload_analyz
### create a program that continuously monitors the sysload, and if a certain threshold is reached then start a trace for a duration of time for the whole system and dump to file and generate a flamegraph for analysis.

#### The Issues
- System load is ambiguous.
- If server has hung, there will be no stack trace of the kernel.
- Application logs are insufficient.
- Kernel logs do not show trace events.


### Credit
FlameGraph (http://www.brendangregg.com/flamegraphs.html)
