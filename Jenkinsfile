// Agent labels
def zOsAgentLabel = ''
//def zOsAgentLabel = 'zOsAgentLabel'
//def zOsAgentLabel = 'sandbox'
def gitUrl = 'gitUrl'
//def gitUrl = "https://github.com/Jayesh-Graytitude/MortgageApplication.git"
def gitAppName = 'gitAppName'
//def gitAppName = "MortgageApplication"
def appGitBranch = 'appGitBranch'
//def appGitBranch = "feature/Test-demo"
def dbbHlq = 'dbbHlq'
//def dbbHlq = "ADCDMST.DBB1"
// Other static variables
def gitCredentials = 'gitCredentials'
//def gitCredentials = "Jayesh-Github"
//def jenkinsWs = 'jenkinsWs'
def zAppbuildScripts = 'zAppbuildScripts'
//def zAppbuildScripts = "/u/gmszfs/zAppbuild"
def appWorkspace = 'appWorkspace'
//def appWorkspace = "/u/gmszfs/app-workspace"
def jenkinsWs = 'jenkinsWs'
def hasBuildFiles = "true"
def dbbBuildType = ''
//def dbbBuildType = '--fullBuild'
def dbbBuildOpts = ''
def JobName = ''
def zosAgentEnv =''
def action =''
//def dbbGroovyzOpts= ''
//def buildOutFolder = ''
//
pipeline {
    agent { label 'built-in' }
    stages {
        stage('Build Environment') {
            steps {
                script {
                    def fullJobName = "$JOB_NAME"
                    env.zosAgentEnv = fullJobName.split('/')[0]
                    appAction = fullJobName.split('/')[1]
                    env.gitAppName = appAction.split('-')[0]
                    env.action = appAction.split('-')[1]
                    echo "zosAgentEnv : ${env.zosAgentEnv}"
                    echo "appAction : ${appAction}"
                    echo "gitAppName : ${env.gitAppName}"
                    echo "action : ${env.action}"
                    
                    env.dbbBuildType = params.dbbBuildType                    
                }

            }
        }
        stage('Get Application Configurations') {
            agent { label "${env.zosAgentEnv}" }
            steps {
                script {
                    def yamlContent = readFile('./appConf.yaml')
                    def yamlMap = readYaml(text: yamlContent)
                    echo "Yaml content : ${yamlMap}"
//
                    def envMap = yamlMap["${env.zosAgentEnv}"]
                    echo "Yaml content1: ${envMap}"
// Application name validation
                    if (envMap.containsKey("${env.gitAppName}")) {
                        echo "*** ''${env.gitAppName}' Application found in configuration YAML file"
                    } else {
                        echo "***[Error] '${env.gitAppName}' Application not found in configuration YAML file"
                    }
//
                    def appMap = yamlMap["${env.zosAgentEnv}"]["${env.gitAppName}"]
                    env.appGitBranch = appMap[appGitBranch]
                    env.appWorkspace = appMap[appWorkspace]
                    env.dbbHlq = appMap[dbbHlq]
                    env.gitAppNameName = appMap[gitAppNameName]
                    env.gitCredentials = appMap[gitCredentials]
                    env.gitUrl = appMap[gitUrl]
                    env.jenkinsWs = appMap[jenkinsWs]
                    env.jenkinsBuildJob = appMap[jenkinsBuildJob]
                    env.zAppbuildScripts = appMap[zAppbuildScripts]
                    
                    echo "env.appGitBranch : ${env.appGitBranch}"
                    echo "env.appWorkspace : ${env.appWorkspace}"
                    echo "env.dbbHlq : ${env.dbbHlq}"
                    echo "env.gitAppNameName : ${env.gitAppNameName}"
                    echo "env.gitCredentials : ${env.gitCredentials}"
                    echo "env.gitUrl : ${env.gitUrl}"
                    echo "env.jenkinsWs : ${env.jenkinsWs}"
                    echo "env.jenkinsBuildJob : ${env.jenkinsBuildJob}"                    
                    echo "env.zAppbuildScripts : ${env.zAppbuildScripts}"                    
//
                }
            }
        }
        stage('Clone Application Repository') {
            agent { label "${env.zosAgentEnv}" }        
            steps {
                dir("${env.appWorkspace}/${env.gitAppName}") {
                     git branch: env.appGitBranch, credentialsId: env.gitCredentials, url: env.gitUrl
                }
            }
        }        
        stage('DBB Build') {
            agent { label "${env.zosAgentEnv}" }        
            steps {
                script{
                 // DBB Build command using Shared Daemon
                    sh "$DBB_HOME/bin/groovyz  -DBB_PERSONAL_DAEMON ${env.zAppbuildScripts}/build.groovy \
                    --workspace ${env.appWorkspace} --application ${env.gitAppName} --outDir ${env.jenkinsWs}/BUILD-${BUILD_NUMBER}/ \
                    --hlq ${env.dbbHlq} ${env.dbbBuildType} ${dbbBuildOpts}"

                // Do not process 'Packaging' and 'UCD Deploy' steps if the build list is empty
                    def files = findFiles(glob: "**BUILD-${BUILD_NUMBER}/**/buildList.txt")
                    hasBuildFiles = files.length > 0 && files[0].length > 0
                }
            }
        }
//        stage('Packaging') {
//            steps {
//                script {
//                    if ( hasBuildFiles ) {
//                        buildOutFolder = sh (script: "ls ${WORKSPACE}/BUILD-${BUILD_NUMBER}  | grep build | sort -u", returnStdout: true).trim()
//                        sh "$DBB_HOME/bin/groovyz $dbbGroovyzOpts ${ucdPackageScripts}/Pipeline/CreateUCDComponentVersion/dbb-ucd-packaging.groovy --buztool ${env.ucdBuztool} --component ${env.ucdComponent} --workDir ${WORKSPACE}/BUILD-${BUILD_NUMBER}/${buildOutFolder} --ucdV2PackageFormat --propertyFile ${WORKSPACE}/buztool.properties"
//                    }
//                }
//            }
//          }
    }
}