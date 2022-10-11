pipeline {
    agent any
    parameters {
      string description: 'Enter the name for new Git repo', name: 'RepoName', trim: true
      string defaultValue: '/home/ubuntu',description: 'Workspace on USS', name: 'usspath', trim: true
//      string defaultValue: 'Jayesh-Graytitude',description: 'Enter your git username', name: 'usrname', trim: true
      password defaultValue: '', description: 'Enter TOKEN for your Git repository', name: 'TOKEN'
	  choice choices: ['true', 'false'], name: 'PublicRepo'
      }
    stages {
        stage('Create New Repo') {
            steps {
                echo "Creating new repo ${RepoName}"
				withCredentials([usernamePassword(credentialsId: 'c0709752-3175-44f0-8833-dcd1fa3be884', passwordVariable: 'TOKEN1', usernameVariable: 'USER')]) {
                    sh '''
                       curl -X POST -u $USER:$TOKEN https://api.github.com/user/repos \
                       -d '{"name": "'$RepoName'","description":"Creating new repository '$RepoName'", \
					   "auto_init":"true","public":"'$PublicRepo'"}' | grep -m 1 clone \
					   | grep -Eo "(http|https)://[a-zA-Z0-9./?=_%:-]*" > temp.txt
                    '''
				}	
            }
        }
        stage('Clone to USS') {
            steps {
                script {
                    env.Newurl = readFile 'temp.txt'
                }
                echo "${env.Newurl}"
                sh 'echo "Printing RepoName again ${RepoName}"'
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
