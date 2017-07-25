#!/bin/bash -xe 

HOSTNAME=`hostname -f`

nohup Xvfb :1 -screen 0 1920x1080x24+32 -extension RANDR &

export DISPLAY=:1

x11vnc -storepasswd vnc /tmp/vncpass
echo "#!/bin/bash" > /vnc-boot.sh
echo "x11vnc -rfbauth /tmp/vncpass -display :1 -forever &" >> /vnc-boot.sh
chmod u+x /vnc-boot.sh

if [ -n "$USER_NAME" ]; then
    if ! id -u ${USER_NAME} ; then
        groupadd ${GROUP_NAME}
        useradd -g ${GROUP_NAME} ${USER_NAME}
    fi
    usermod -u ${USER_ID} ${USER_NAME}
    groupmod -g ${GROUP_ID} ${GROUP_NAME}
else
    USER_NAME="root"
    GROUP_NAME="root"
fi

mkdir -p /home/${USER_NAME}/Downloads
chown ${USER_NAME}:${GROUP_NAME} /tmp/selenium-server-standalone-3.0.1.jar
chown ${USER_NAME}:${GROUP_NAME} /tmp/chromedriver
chown ${USER_NAME}:${GROUP_NAME} /home/${USER_NAME}
chown ${USER_NAME}:${GROUP_NAME} /home/${USER_NAME}/Downloads

su - ${USER_NAME} -c "mkdir -p /home/${USER_NAME}/log/selenium"
su - ${USER_NAME} -c "java -Dwebdriver.chrome.driver=/tmp/chromedriver -jar /tmp/selenium-server-standalone-3.0.1.jar -host $HOSTNAME -role node -hub http://${SELENIUM_GRID:=seleniumgrid.cd.stratio.com:4444}/grid/register -browser browserName=chrome,version=${VERSION}${ID} >> /home/${USER_NAME}/log/selenium/selenium-chrome.log &"
su - ${USER_NAME} -c "tail -F /home/${USER_NAME}/log/selenium/selenium-chrome.log"
