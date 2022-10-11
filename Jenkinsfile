pipeline {
    agent any
    parameters {
      string description: 'Enter the name for new Git repo', name: 'reponame', trim: true
      string defaultValue: '/home/ubuntu',description: 'Workspace on USS', name: 'usspath', trim: true
      string defaultValue: 'Jayesh-Graytitude',description: 'Enter your git username', name: 'usrname', trim: true
      password defaultValue: '', description: 'Enter TOKEN for your Git repository', name: 'password'
      }
    stages {
        stage('Create New Repo') {
            steps {
                echo "Creating new repo ${reponame}"
                sh '''
                   #!/bin/bash
                   curl -X POST -u Jayesh-Graytitude:${password} https://api.github.com/user/repos \
                    -d '{"name": "'$reponame'","description":"Creating new repository '$reponame'", \
					"auto_init":"true","public":"false"}' | grep -m 1 clone \
					| grep -Eo "(http|https)://[a-zA-Z0-9./?=_%:-]*" > temp.txt
                '''  
            }
        }
        stage('Clone to USS') {
            steps {
                script {
                    env.Newurl = readFile 'temp.txt'
                }
                echo "${env.Newurl}"
                sh 'echo "Printing reponame again ${reponame}"'
				sh "pwd"
				sh "mkdir tempclone2"
                dir('/var/lib/jenkins/workspace/jenkinsfiletrial/tempclone1') {
                  sh "pwd"
				  sh "git clone ${env.Newurl}"
				  sh "ls -l"
                }
                sh "pwd"
            }
        }
        stage('End') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
