#! /bin/sh
# /etc/init.d/InSightsRundeckAgent

### BEGIN INIT INFO
# Provides: Runs a Python script on startup
# Required-Start: BootPython start
# Required-Stop: BootPython stop
# Default-Start: 2 3 4 5
# Default-stop: 0 1 6
# Short-Description: Simple script to run python program at boot
# Description: Runs a python program at boot
### END INIT INFO
#export INSIGHTS_AGENT_HOME=/home/ec2-user/insightsagents
source /etc/profile

case "$1" in
  start)
    if [[ $(ps aux | grep '[d]eployment.rundeck.RundeckAgent' | awk '{print $2}') ]]; then
     echo "InSightsRundeckAgent already running"
    else
     echo "Starting InSightsRundeckAgent"
     cd $INSIGHTS_AGENT_HOME/PlatformAgents/rundeck
     python -c "from com.cognizant.devops.platformagents.agents.deplyment.rundeck.RundeckAgent import RundeckAgent; RundeckAgent()" &
    fi
    if [[ $(ps aux | grep '[d]eployment.rundeck.RundeckAgent' | awk '{print $2}') ]]; then
     echo "InSightsRundeckAgent Started Sucessfully"
    else
     echo "InSightsRundeckAgent Failed to Start"
    fi
    ;;
  stop)
    echo "Stopping InSightsRundeckAgent"
    if [[ $(ps aux | grep '[d]eployment.rundeck.RundeckAgent' | awk '{print $2}') ]]; then
     sudo kill -9 $(ps aux | grep '[d]eployment.rundeck.RundeckAgent' | awk '{print $2}')
    else
     echo "InSIghtsRundeckAgent already in stopped state"
    fi
    if [[ $(ps aux | grep '[d]eployment.rundeck.RundeckAgent' | awk '{print $2}') ]]; then
     echo "InSightsRundeckAgent Failed to Stop"
    else
     echo "InSightsRundeckAgent Stopped"
    fi
    ;;
  restart)
    echo "Restarting InSightsRundeckAgent"
    if [[ $(ps aux | grep '[d]eployment.rundeck.RundeckAgent' | awk '{print $2}') ]]; then
     echo "InSightsRundeckAgent stopping"
     sudo kill -9 $(ps aux | grep '[d]eployment.rundeck.RundeckAgent' | awk '{print $2}')
     echo "InSightsRundeckAgent stopped"
     echo "InSightsRundeckAgent starting"
     cd $INSIGHTS_AGENT_HOME/PlatformAgents/rundeck
     python -c "from com.cognizant.devops.platformagents.agents.deplyment.rundeck.RundeckAgent import RundeckAgent; RundeckAgent()" &
     echo "InSightsRundeckAgent started"
    else
     echo "InSightsRundeckAgent already in stopped state"
     echo "InSightsRundeckAgent starting"
     cd $INSIGHTS_AGENT_HOME/PlatformAgents/rundeck
     python -c "from com.cognizant.devops.platformagents.agents.deplyment.rundeck.RundeckAgent import RundeckAgent; RundeckAgent()" &
     echo "InSightsRundeckAgent started"
    fi
    ;;
  status)
    echo "Checking the Status of InSightsRundeckAgent"
    if [[ $(ps aux | grep '[d]eployment.rundeck.RundeckAgent' | awk '{print $2}') ]]; then
     echo "InSightsRundeckAgent is running"
    else
     echo "InSightsRundeckAgent is stopped"
    fi
    ;;
  *)
    echo "Usage: /etc/init.d/InSightsRundeckAgent {start|stop|restart|status}"
    exit 1
    ;;
esac
exit 0
