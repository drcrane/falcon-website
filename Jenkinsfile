def docker_registry = 'drcrane/falcon-website'
def docker_image = ''
def docker_image_version = ''
def docker_registry_credentials = 'cdaa15fc-a2e8-4bf9-aa9b-4fb626493961'

node {
	stage('Get Source') {
		checkout scm
	}
	stage('Pre-build') {
		if (fileExists('prebuild.sh')) {
			sh './prebuild.sh'
		}
		docker_image_version = sh (
			script: 'git --no-pager log -1 --pretty="format:%h"',
			returnStdout: true
		).trim()
	}
	stage('Build') {
		docker_image = docker.build docker_registry + ":${env.BUILD_NUMBER}-${docker_image_version}"
	}
	stage('Push to Docker Hub') {
		docker.withRegistry ('', docker_registry_credentials) {
			docker_image.push();
		}
	}
	stage('Deploy') {
		// Tell Kubernetes to run the latest version
	}
	stage('Cleanup') {
		sh "docker rmi ${docker_registry}:${env.BUILD_NUMBER}-${docker_image_version}"
		cleanWs()
	}
}

