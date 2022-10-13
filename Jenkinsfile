pipeline {
	agent any
	parameters {
		string description: 'Enter the name for new Git repo', name: 'RepoName', trim: true
		string defaultValue: '/tmp/jenkins-temp',description: 'Workspace on USS', name: 'Newpath', trim: true
		choice choices: ['true', 'false'], name: 'PublicRepo'
	}
	stages {
		stage('Create New Repo') {
			steps {
				echo "Creating new repo ${RepoName}"
				withCredentials([usernamePassword(credentialsId: 'MyGitHub', passwordVariable: 'SECRET', usernameVariable: 'USER')]) {
				sh '''
					curl -X POST -u ${USER}:${SECRET} https://api.github.com/user/repos \
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
				dir("${Newpath}") {
					sh '''
						if [ -d "${RepoName}" ]; then
							echo "Directory ${DIR} is already present... Deleting it"
							rm -r "${RepoName}"
						else
							echo "Good to clone.."
						fi
					'''	
					sh "git clone ${env.Newurl}"
				}
			}
		}
		stage('Migrate from Mainframe') {
			steps {
				echo 'Migrating....'
			}
		}
		stage('Clean Worspace') {
			steps {
				cleanWs()
			}
		}
	}
}
