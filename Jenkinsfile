pipeline {
    agent any
    environment {
       REGISTRY = "my-registry:55001"
       USER = "ecs"
    }
    stages {
        stage('Audit') {
            steps {
                sh 'docker version && docker-compose version'
            }
        }
        stage('Build') {
            steps {
                dir('.') {
                    sh 'docker-compose build'
                }
            }
        }
        stage('Test') {
            steps {
                dir('.') {
                    sh '''
                        docker-compose up -d
                        sleep 20
                        docker-compose -f docker-compose.yml -f docker-compose-test.yml build
                        docker-compose -f docker-compose.yml -f docker-compose-test.yml up
                    '''
                }
            }
        }
        stage('Push') {
            steps {
                dir('.') {
                    sh 'docker-compose push'
                    echo "Pushed web to http://$REGISTRY/v2/diamol/ch11-numbers-web/tags/list"
                }
            }
        }
    }
}
