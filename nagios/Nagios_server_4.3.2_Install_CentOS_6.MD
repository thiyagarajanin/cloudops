### 

1. Download Naigos source package

```
cd \tmp
wget https://downloads.sourceforge.net/project/nagios/nagios-4.x/nagios-4.3.2/nagios-4.3.2.tar.gz
tar -zxvf nagios-4.3.2.tar.gz
cd nagios-4.3.2
```
2. Create needed user and group
```
useradd nagios
usermod -G nagcmd nagios
```
3. Compile and Install
```
```
