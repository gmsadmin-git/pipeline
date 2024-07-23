// Agent labels
def zOsAgentLabel = 'sandbox'
//def gitUrl = 'gitUrl'
def gitUrl = "https://github.com/Jayesh-Graytitude/MortgageApplication.git"
//def gitApp = 'gitApp'
def gitApp = "MortgageApplication"
def appGitBranch = "feature/Test-demo"
//def dbbHlq = 'dbbHlq'
def dbbHlq = "ADCDMST.DBB1"
def ucdApplication = 'ucdApplication'
def ucdComponent = 'ucdComponent'
def ucdProcess = 'ucdProcess'
def ucdEnv = 'ucdEnv'
// Other static variables
def Gitcredentials = "d1ad82f8-5d28-40c6-94d9-033d8705f812"
def JENKINSWS = "/slocal/devops/usr/lpp/IBM/jenkins/agent/e2e-pipeline/workspace"
def zAppbuildScripts = "/u/gmszfs/zAppbuild"
def ucdPackageScripts = "$JENKINSWS/ucd-package-scripts"
def appWorkspace = "/u/gmszfs/app-workspace"
def hasBuildFiles = "true"
def dbbBuildType = "--fullBuild"
def dbbBuildOpts = ""
def dbbGroovyzOpts= ''
def BUILD_OUTPUT_FOLDER = ''
//
pipeline {
    agent { label zOsAgentLabel }
    stages {
//        stage('CleanWS') {
//            steps {
//                sh '''echo Cleaning Workspace'''
//                cleanWs()
//            }
//        }
        stage('Clone Application Repository') {
            steps {
                dir("${appWorkspace}/${env.gitApp}") {
                     git branch: appGitBranch, credentialsId: Gitcredentials, url: env.gitUrl
                }
            }
        }
        stage('DBB Build') {
            steps {
                script{
                 // DBB Build command using Shared Daemon
                    sh "$DBB_HOME/bin/groovyz  -DBB_PERSONAL_DAEMON ${zAppbuildScripts}/build.groovy \
                    --workspace ${appWorkspace} --application ${env.gitApp} --outDir ${WORKSPACE}/BUILD-${BUILD_NUMBER}/ \
                    --hlq ${env.dbbHlq} ${dbbBuildType} ${dbbBuildOpts}"

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
//                        BUILD_OUTPUT_FOLDER = sh (script: "ls ${WORKSPACE}/BUILD-${BUILD_NUMBER}  | grep build | sort -u", returnStdout: true).trim()
//                        sh "$DBB_HOME/bin/groovyz $dbbGroovyzOpts ${ucdPackageScripts}/Pipeline/CreateUCDComponentVersion/dbb-ucd-packaging.groovy --buztool ${env.ucdBuztool} --component ${env.ucdComponent} --workDir ${WORKSPACE}/BUILD-${BUILD_NUMBER}/${BUILD_OUTPUT_FOLDER} --ucdV2PackageFormat --propertyFile ${WORKSPACE}/buztool.properties"
//                    }
//                }
//            }
//          }
    }
}