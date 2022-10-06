pipeline {
    agent any
    parameters {
                string description: 'Enter the Git repo name to be created', name: 'reponame', trim: true
                password defaultValue: '', description: 'Enter password got your Git repository', name: 'password'
                }
    stages {
        stage('Jayesh') {
            steps {
                echo "Jayesh Building.."
                echo "Reponame is ${param.name}"
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
