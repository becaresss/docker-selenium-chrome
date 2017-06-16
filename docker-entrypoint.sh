#!/bin/bash -xe 

HOSTNAME=`hostname -f`

nohup Xvfb :1 -screen 0 1920x1080x24+32 -extension RANDR &

export DISPLAY=:1

x11vnc -storepasswd vnc /tmp/vncpass
echo "#!/bin/bash" > /vnc-boot.sh
echo "x11vnc -rfbauth /tmp/vncpass -display :1 -forever &" >> /vnc-boot.sh
chmod u+x /vnc-boot.sh

if [ -n "$USER" ]; then

	if [ ! -d "/home/${USER}/Downloads" ]; then
    	su - ${USER} -c "mkdir -p /home/${USER}/Downloads"
	fi

    USER_ID=`ls -la /home/${USER}/Downloads | head -n2 | tail -n1 | tr -s ' ' | cut -f3 -d' '`
    GROUP_ID=`ls -la /home/${USER}/Downloads| head -n2 | tail -n1 | tr -s ' ' | cut -f4 -d' '`

	usermod -u 666 ${USER_ID}
	groupmod -g 666 ${GROUP_ID}

	chown ${USER_ID}:${GROUP_ID} /tmp/selenium-server-standalone-3.0.1.jar
	chown ${USER_ID}:${GROUP_ID} /tmp/chromedriver

	su - ${USER_ID} -c "mkdir -p /home/${USER_ID}/log/selenium"
	su - ${USER_ID} -c "java -Dwebdriver.chrome.driver=/tmp/chromedriver -jar /tmp/selenium-server-standalone-3.0.1.jar -host $HOSTNAME -role node -hub http://${SELENIUM_GRID:=seleniumgrid.cd.stratio.com:4444}/grid/register -browser browserName=chrome,version=${VERSION}${ID} >> /home/${USER_ID}/log/selenium/selenium-chrome.log &"
	su - ${USER_ID} -c "tail -F /home/${USER_ID}/log/selenium/selenium-chrome.log"
else
	mkdir -p /tmp/log/selenium
	java -Dwebdriver.chrome.driver=/tmp/chromedriver -jar /tmp/selenium-server-standalone-3.0.1.jar -host $HOSTNAME -role node -hub http://${SELENIUM_GRID:=seleniumgrid.cd.stratio.com:4444}/grid/register -browser browserName=chrome,version=56${ID} >> /tmp/log/selenium/selenium-chrome.log &
	tail -F /tmp/log/selenium/selenium-chrome.log
fi
