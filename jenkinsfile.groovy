node {
    properties([pipelineTriggers([cron('* * * * *')])])
    stage("Stage1"){
        echo "Hello World"
    }
    stage("Stage2"){
        echo "Hello World"
    }
    stage("Stage3"){
        echo "Hello World"
    }
    stage("Send Notification to slack"){
        echo "Hello World"
        slackSend channel: 'nagios_alerts', message: 'Completed'
        mail bcc: 'alisevhp@gmail.com', body: 'message', cc: 'farrukh@gmail.com', from: '', replyTo: '', subject: 'Completed', to: 'farrukh@gmail.com'
    }
}