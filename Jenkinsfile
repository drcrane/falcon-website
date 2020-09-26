def docker_registry = 'drcrane/falkon-website'
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
		/* Check there is no space in the JOB_NAME */
		if ("${env.JOB_NAME}".indexOf(" ") == -1) {
			// sh 'docker build --tag ${JOB_NAME}:$(git log -1 --pretty="format:%h") --file Dockerfile .'
			docker_image = docker.build docker_registry + ":${docker_image_version}"
		} else {
			echo 'Cannot have spaces in job name'
			currentBuild.result = 'FAILURE'
		}
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
		cleanWs()
	}
}

