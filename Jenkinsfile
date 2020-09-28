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
		sshagent(credentials: ['e92e2ece-2e9d-44bb-a377-d8a333c1f327']) {
			sh "ssh -o StrictHostKeyChecking=no debian@172.17.0.1 " +
				"\"sudo ./falcon-website-deploy.sh ${env.BUILD_NUMBER}-${docker_image_version}\""
			sh "ssh -o StrictHostKeyChecking=no debian@172.17.0.1 " + 
				"\"sudo KUBECONFIG=/root/azure-falcon-website-k8s minikube " +
				"kubectl set image deployment/falcon-website-app " +
				"falcon-website-container=${docker_registry}:${env.BUILD_NUMBER}-${docker_image_version}\""
		}
	}
	stage('Cleanup') {
		// Because minikube is hosted on this machine attempting to remove it will cause the build to fail.
		// ignore for now.
		//sh "docker rmi ${docker_registry}:${env.BUILD_NUMBER}-${docker_image_version}"
		cleanWs()
	}
}

