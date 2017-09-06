#!/bin/bash
#
# Author : Thiyagraajan K (kthiyagarajan@vanenburgsoftware.com
#
###
#
## Clean up
#
cd /opt/logstash/csv/unknown_status 
rm -rf *.csv

#
## Set Date
#
toDate=`date`
fromDate=`date -d "yesterday"`

#
## Create CSV
#
export JAVA_HOME=/opt/worksapce/jdk1.8.0_131
/usr/share/logstash/bin/logstash -f unknown_status_csv.conf

#
## Body Content
#
echo "<html> <header> </hrader><body>Dear Administrator,<br><br>Please find below the list of sensors and gateways in UNKNOWN status<br><br>" > mailbody.html
echo "<b>From :</b> $fromDate <b>To :</b> $toDate <br><br>" >> mailbody.html
echo "<table border="1">" >> mailbody.html 
while read INPUT ; do 
	echo "<tr><td>${INPUT//,/</td><td>}</td></tr>" >> mailbody.html ; 
done < unknown_sensor_gateway.csv ; 
echo "</table>" >> mailbody.html
echo "<br><br>Sent from,<br>AntTail Cloud Monitors</body></html>" >> mailbody.html

#
## Subject
#
#subject = INFO: [AntTail] Sensors and Gateways in Unknown status

#
## To Addresses
#
supportAddress="stina@vanenburgsoftware.com, kthiyagarajan@vanenburgsoftware.com, agalyak@vanenburgsoftware.com, backoffice@anttail.com, mark.roemers@anttail.com"
#supportAddress="kthiyagarajan@vanenburgsoftware.com"

#
## Send Mail
#
mutt -e 'set content_type="text/html"' $supportAddress -a "unknown_sensor_gateway.csv" -s "INFO: [AntTail] Sensors and Gateways in Unknown status" < mailbody.html
