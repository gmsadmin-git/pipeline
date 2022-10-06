pipeline {
    agent any
    parameters {
      string description: 'Enter the Git repo name to be created', name: 'reponame', trim: true
    }
    stages {
        stage('Jayesh') {
            steps {
                echo "Jayesh Building.."
                echo "Reponame is ${reponame}"
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
