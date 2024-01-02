pipeline {
    agent any
    environment {
       REGISTRY = "my-registry:55000"
       IMAGE = ""
    }
    stages {
        stage('Build') {
            steps {
                sh """
                    IMAGE="${Registry}/gen:ci-${env.BUILD_NUMBER}"
                    docker build -t ${Image} .

                    docker push ${Image}
                    """
            }
        }
        stage('Integration') {
            steps {
                sh '''
                    docker-compose up \
                    --force-recreate \
                    --abort-on-container-exit \
                    --build
                    '''
            }
        }
    }
}
