pipeline {
    agent any
    environment {
       registry = "my-registry:55000"
    }
    stages { 
        stage('Build') {
            steps {
                try {
                    def testtool='dotnet'
                    sh """${testtool}\" test --no-build --logger "trx;LogFileName=UnitTests.xml" /pathtotest"""
                } catch (error) {
                    currentBuild.result = 'UNSTABLE'
                        errorDetails = 
                        """Unit tests failure! 
                        Suggestions:
                        1. verify that tests .csproj file target framework 'net6.0' or better
                        2. verify that the tests are running
                        Error: ${error}"""
                        echo(errorDetails)
                }
                //push test result to my api if they exist
                if (fileExists('/var/jenkins_home/workspace/generator/UnitTests.xml')){
                    sh """curl -X POST -H "Content-Type:application/xml" -d @/var/jenkins_home/workspace/MyJob/UnitTests.xml"""
                }
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
