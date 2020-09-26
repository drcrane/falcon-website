node {
	stage('Get Source') {
		checkout scm
	}
	stage('Pre-build') {
		if (fileExists('prebuild.sh')) {
			sh './prebuild.sh'
		}
	}
	stage('Build') {
		/* Check there is no space in the JOB_NAME */
		if ("${env.JOB_NAME}".indexOf(" ") == -1) {
			sh 'docker build --tag ${JOB_NAME}:$(git log -1 --pretty="format:%h") --file Dockerfile .'
		} else {
			echo 'Cannot have spaces in job name'
			currentBuild.result = 'FAILURE'
		}
	}
	stage('Deploy') {
		//
	}
}

