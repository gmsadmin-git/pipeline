pipeline {
    agent any
    parameters {
      string description: 'Enter the Git repo name to be created', name: 'reponame', trim: true
      string defaultValue: '/home/ubuntu',description: 'Enter the USS path', name: 'usspath', trim: true
      string defaultValue: 'Jayesh-Graytitude',description: 'Enter your git username', name: 'usrname', trim: true
      password defaultValue: '', description: 'Enter password got your Git repository', name: 'password'
      }
    environment {
      repo = ''
      }  
    stages {
        stage('Create New Repo') {
            steps {
                echo "Creating new repo ${reponame}"
                sh '''
                   #!/bin/bash
                   temp=$(curl -X POST -u Jayesh-Graytitude:${password} https://api.github.com/user/repos \
                         -d '{"name": "'$reponame'"}' | grep -m 1 clone | grep -Eo "(http|https)://[a-zA-Z0-9./?=_%:-]*")
                   repo=$temp
                '''  
            }
        }
        stage('Clone to USS') {
            steps {
//               dir('/home/ubuntu') { // or absolute path
                sh 'echo "Printing reponame again ${reponame}"'
            }
        }
        stage('End') {
            steps {
                echo 'Paul Deploying....'
            }
        }
    }
}
