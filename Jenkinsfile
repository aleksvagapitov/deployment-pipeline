pipeline {
    agent any
    environment {
       registry = "my-registry:55000"
    }
    stages { 
        stage('Build') {
            steps {
                sh """
                    image="${registry}/gen:ci-${env.BUILD_NUMBER}"
                    docker build -t \$image .

                    docker push \$image
                    """
            }
        }
        stage('Integration') {
            steps {
                dir ("integration"){
                    sh '''
                        docker-compose -f docker-compose.jenkins.test.yml up \
                        --force-recreate \
                        --abort-on-container-exit \
                        --build

                        docker-compose down
                        '''
                }
            }
        }
        stage('Deploy Demo') {
            steps {
                dir ("deploy") {
                    sh 'docker stack deploy -c demo.yml demo'
                }
            }
        }
    }
    post {
        always {
            mstest(testResultsFile: '**/*.trx', failOnError: false, keepLongStdio: true)
        }
    }
}
