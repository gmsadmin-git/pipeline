// Variables
def zOsAgentLabel = ''
def gitUrl = 'gitUrl'
def gitAppName = 'gitAppName'
def appGitBranch = 'appGitBranch'
def dbbHlq = 'dbbHlq'
def gitCredentials = 'gitCredentials'
def zAppbuildScripts = 'zAppbuildScripts'
def appWorkspace = 'appWorkspace'
def jenkinsBuildJob = 'jenkinsBuildJob'
def zAppbuildBranch = 'zAppbuildBranch'
def zAppRepo = 'zAppRepo'
def zAppWorkspace = 'zAppWorkspace'
def hasBuildFiles = 'true'
def dbbBuildType = ''
def dbbBuildOpts = ''
def JobName = ''
def zosAgentEnv =''
def action =''
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
                    //echo "zosAgentEnv : ${env.zosAgentEnv}"
                    //echo "appAction : ${appAction}"
                    //echo "gitAppName : ${env.gitAppName}"
                    //echo "action : ${env.action}"
                    
                    env.dbbBuildType = params.dbbBuildType
                    env.dbbBuildOpts = params.dbbBuildOpts                    
                }

            }
        }
        stage('Get Application Configurations') {
            agent { label "${env.zosAgentEnv}" }
            steps {
                script {
                    def yamlContent = readFile('./appConf.yaml')
                    def yamlMap = readYaml(text: yamlContent)
//
                    def envMap = yamlMap["${env.zosAgentEnv}"]
// Application name validation
//                    if (envMap.containsKey("${env.gitAppName}")) {
//                        echo "*** '${env.gitAppName}' Application found in configuration YAML file"
//                    } else {
//                        echo "***[Error] '${env.gitAppName}' Application not found in configuration YAML file"
//                    }
//
                    def appMap = yamlMap["${env.zosAgentEnv}"]["${env.gitAppName}"]
                    env.appGitBranch = appMap[appGitBranch]
                    env.appWorkspace = appMap[appWorkspace]
                    env.dbbHlq = appMap[dbbHlq]
                    env.gitAppName = appMap[gitAppName]
                    env.gitCredentials = appMap[gitCredentials]
                    env.gitUrl = appMap[gitUrl]
                    env.jenkinsBuildJob = appMap[jenkinsBuildJob]
                    env.zAppbuildScripts = appMap[zAppbuildScripts]
                    env.zAppbuildBranch = appMap[zAppbuildBranch]
                    env.zAppRepo = appMap[zAppRepo]
//                    
                    echo "env.appGitBranch : ${env.appGitBranch}"
                    echo "env.appWorkspace : ${env.appWorkspace}"
                    echo "env.dbbHlq : ${env.dbbHlq}"
                    echo "env.gitAppName : ${env.gitAppName}"
                    echo "env.gitCredentials : ${env.gitCredentials}"
                    echo "env.gitUrl : ${env.gitUrl}"
                    echo "env.jenkinsBuildJob : ${env.jenkinsBuildJob}"                    
                    echo "env.zAppbuildScripts : ${env.zAppbuildScripts}"
                    echo "env.zAppbuildBranch : ${env.zAppbuildBranch}"                    
                    echo "env.zAppRepo : ${env.zAppRepo}"                    
//
                }
            }
        }
        stage('Clone zAppbuild Repository') {
            agent { label "${env.zosAgentEnv}" }        
            steps {
                dir("${env.zAppbuildScripts}") {
                     git branch: env.zAppbuildBranch, credentialsId: env.gitCredentials, url: env.zAppRepo
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
                    sh "$DBB_HOME/bin/groovyz  -DBB_PERSONAL_DAEMON ${env.zAppbuildScripts}/build.groovy \
                    --workspace ${env.appWorkspace} \
                    --application ${env.gitAppName} \
                    --outDir ${WORKSPACE}/BUILD-${BUILD_NUMBER}/ \
                    --hlq ${env.dbbHlq} ${env.dbbBuildType} ${env.dbbBuildOpts}"

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