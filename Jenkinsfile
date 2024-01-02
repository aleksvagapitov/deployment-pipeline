pipeline {
    agent any
    environment {
       REGISTRY = "my-registry:55000"
    }
    stages {
        stage('Build') {
            steps {
                sh """
                    image="${Registry}/gen:ci-${env.BUILD_NUMBER}"
                    docker build -t $image .

                    docker push $image
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
