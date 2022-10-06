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
                echo "Reponame is ${password}"
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
