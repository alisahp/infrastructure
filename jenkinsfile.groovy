node {
    properties([pipelineTriggers([cron('* * * * *')])])
    stage("Pull Repo"){
        git 'https://github.com/farrukh90/packer.git'    
    }
    stage("Deploy to Dev"){
        echo "Hello World"
    }
    stage("Wait"){
        //input 'Deploy to QA? '
        //sleep 3
    }
    stage("Deploy to QA"){
        echo "Hello World"
    }
    stage("Script"){
		sh label: '', script: 
		'''#!/bin/bash
			if [ ! -f /tmp/foo.txt ]; 
			then
				echo "File not found!"
				echo "Creating a file"
				touch "/tmp/foo.txt"
			fi
		'''
	}

    stage("Send Notification to slack"){
        echo "Hello World"
        slackSend channel: 'nagios_alerts', message: 'Completed'
        mail bcc: 'farrukh@gmail.com', body: 'message', cc: 'farrukh@gmail.com', from: '', replyTo: '', subject: 'Completed', to: 'farrukh@gmail.com'
    }
}