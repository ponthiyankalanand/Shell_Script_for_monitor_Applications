echo 'script start running'
date
logpath='/opt/app/billing/billing_dunning/logs/catalina.out'
appName='billing_dunning'
startUpPath='/opt/app/billing/billing_dunning/bin/'
startupfile='startup.sh'

pid=$(ps -aef|grep $appName|grep -v grep |awk '{print $2}')
echo $pid
if [ -z "$pid" ]
then
	echo "app is down :("
	echo "Tring to make it up."
	echo "clearing startup log"
	>$logpath
	echo "starting app......"
	cd $startUpPath
	#stahdalone app
	#nohup sh standalone.sh -b 0.0.0.&
	#tomacat app
	sh $startupfile
	sleep 2m
	#for standalone app
	#logs=grep 'started' $logpath
	#if [ $logs == 'WILDFLY' ]
	#for tomcat app
	logs=$(grep 'started' $logpath)
	if [[ $logs =~ 'started' ]]
	then
		echo "app started successfuly"

	else
		echo "Cant start the app. :("
	fi
else
	echo "app is up :)"
fi