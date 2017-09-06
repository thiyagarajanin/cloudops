#!/bin/bash
#
# Author : Thiyagraajan K (kthiyagarajan@vanenburgsoftware.com
#
###
#
## Clean up
#
cd /opt/logstash/csv/invalid_deviation
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
/usr/share/logstash/bin/logstash -w 1 -f invalid_deviation_csv.conf

#
## Body Content
#
echo "<html> <header> </hrader><body>Dear Administrator,<br><br>The following sensors are sending data outside the allowed deviation in last 24 hours:<br><br>" > mailbody.html
echo "<b>From :</b> $fromDate <b>To :</b> $toDate <br><br>" >> mailbody.html
echo "<table border="1">" >> mailbody.html 
while read INPUT ; do 
	echo "<tr><td>${INPUT//,/</td><td>}</td></tr>" >> mailbody.html ; 
done < Sensors_with_invalid_measured_time.csv ; 
echo "</table>" >> mailbody.html
echo "<br><br>Sent from,<br>AntTail Cloud Monitors</body></html>" >> mailbody.html

#
## Subject
#
#subject = INFO: [AntTail] Sensors and Gateways in Unknown status

#
## To Addresses
#
supportAddress="backoffice@anttail.com, mark.roemers@anttail.com"
#supportAddress="kthiyagarajan@vanenburgsoftware.com"
#ccAddress="kthiyagarajan@vanenburg.com"
ccAddress="stina@vanenburgsoftware.com, kthiyagarajan@vanenburgsoftware.com, agalyak@vanenburgsoftware.com"
#
## Send Mail
#
#mutt -e 'set content_type="text/html"' $supportAddress -c $ccAddress -a "Sensors_with_invalid_measured_time.csv" -s "INFO: [AntTail] Sensors and Gateways with Invalid measured time" < mailbody.html
