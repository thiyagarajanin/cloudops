### Files and scripts for Nagios and NRPE

### In Client instances

1. Install NRPE and Nagios common plugins in client instances which are needs to be monitored

`yum install nrpe nagios-plugins-all`

2. Download custom config files

```
cd /usr/lib64/nagios/plugins
wget https://raw.githubusercontent.com/DennyZhang/devops_public/tag_v6/nagios_plugins/check_proc_cpu/check_proc_cpu.sh
wget https://raw.githubusercontent.com/DennyZhang/devops_public/tag_v6/nagios_plugins/check_proc_mem/check_proc_mem.sh
wget https://raw.githubusercontent.com/DennyZhang/devops_public/tag_v6/nagios_plugins/check_proc_threadcount/check_proc_threadcount.sh
wget https://raw.githubusercontent.com/whereisaaron/linux-check-mem-nagios-plugin/master/check_mem
wget https://raw.githubusercontent.com/mindbat/nagios-cpu-usage/master/linux-cpu-usage.py -O check_cpu.py

chmod 655 check_proc_cpu.sh check_proc_mem.sh check_proc_threadcount.sh check_mem check_cpu.py
```
3. Backup original NRPE Config File 
```
cd /etc/nagios/
mv nrpe.cfg /tmp
```
4. Download NRPE Config file

`wget https://raw.githubusercontent.com/thiyagarajanin/cloudops/master/nagios/nrpe.cfg`

5. Restart NRPE service

`service nrpe restart`

6. Allow port 5666 in system and internet firewall

> In Less than CentOS 7 
```
iptables -A INPUT -p tcp --dport 5666 -j ACCEPT
iptables-save | sudo tee /etc/sysconfig/iptables
service iptables restart
```
> In Centos 7
```
firewall-cmd --zone=public --add-port=5666/tcp --permanent
firewall-cmd --reload
```

### Nagios Server
