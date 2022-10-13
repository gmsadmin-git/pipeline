pipeline {
    agent any
    parameters {
      string description: 'Enter the name for new Git repo', name: 'RepoName', trim: true
      string defaultValue: '/tmp/jenkins-temp',description: 'Workspace on USS', name: 'Newpath', trim: true
      string defaultValue: 'Jayesh-Graytitude',description: 'Enter your git username', name: 'USER', trim: true
      password defaultValue: '', description: 'Enter TOKEN for your Git repository', name: 'TOKEN'
	  choice choices: ['true', 'false'], name: 'PublicRepo'
      }
    stages {
        stage('Create New Repo') {
            steps {
                echo "Creating new repo ${RepoName}"
// Jayesh - Update the script to use credentials as secret from Jenkins and not display the same in logs				
//				withCredentials([usernamePassword(credentialsId: 'c0709752-3175-44f0-8833-dcd1fa3be884', passwordVariable: 'TOKEN1', usernameVariable: 'USER')]) {
				withCredentials([string(credentialsId: 'Mygithub', variable: 'SECRET')]) {
                echo "My secret text is '${SECRET}'"
				}
                    sh '''
                       curl -X POST -u ${USER}:${SECRET} https://api.github.com/user/repos \
                       -d '{"name": "'$RepoName'","description":"Creating new repository '$RepoName'", \
					   "auto_init":"true","public":"'$PublicRepo'"}' | grep -m 1 clone \
					   | grep -Eo "(http|https)://[a-zA-Z0-9./?=_%:-]*" > temp.txt
                    '''
//				}	
            }
        }
        stage('Clone to USS') {
// Jayesh - Update the script to change the user who can access the desired path on USS from Jenkins credentials
            steps {
                script {
                    env.Newurl = readFile 'temp.txt'
                }
                echo "${env.Newurl}"
				sh "pwd"
//				sh "rm -r '$RepoName'"
//				sh "mkdir '$RepoName'"
                  dir('/tmp/jenkins-temp') {
//                  sh "pwd"
				    sh "git clone ${env.Newurl}"
//				    sh "ls -l"
                  }
//                sh "pwd"
            }
        }
        stage('End') {
// Jayesh - Switch the path to migrate file and trigger migration from MF to USS
// Test this by creating a sepearate shell script
            steps {
                echo 'Deploying....'
            }
        }
    }
}