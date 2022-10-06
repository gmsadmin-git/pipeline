pipeline {
    agent any
    parameters {
      string description: 'Enter the Git repo name to be created', name: 'reponame', trim: true
      string description: 'Enter the USS path', name: 'usspath', trim: true
      string description: 'Enter your git username', name: 'usrname', trim: true
      password defaultValue: '', description: 'Enter password got your Git repository', name: 'password'
    }
    stages {
        stage('Jayesh') {
            steps {
                echo "Jayesh Building.."
                echo "Reponame is ${reponame}"
                echo "USS path is ${usspath}"
                echo "Git user name is ${usrname}"
                sh '''
                    #!/bin/bash
                    temp=$(curl -X POST -u $usrname : $password https://api.github.com/user/repos \
                          -d '{"name": "'$reponame'"}' | grep -m 1 clone | grep -Eo "(http|https)://[a-zA-Z0-9./?=_%:-]*")
                   '''       
                echo $temp
                  }
        }
        stage('Srini') {
            steps {
                echo 'Srini Testing..'
            }
        }
        stage('Paul') {
            steps {
                echo 'Paul Deploying....'
            }
        }
    }
}
