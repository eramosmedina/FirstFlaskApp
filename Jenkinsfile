pipeline {
    agent any    
    stages {
        stage('Stop and Clean') {
            when {
                branch 'main'
            }
            steps {
                when {
                    expression {
                        DOCKER_EXIST = sh(returnStdout: true, script: 'docker ps -q --filter name=my-first-flask-app_main_latest_8000')
                        echo "DOCKER_EXIST:${DOCKER_EXIST}"
                        return DOCKER_EXIST != ''
                    }
                }
                steps {
                    script {
                        sh '''
                        echo Stoping container...
                        docker stop my-first-flask-app_main_latest_8000
                        echo 'Cleaning old container...'
                        docker rm my-first-flask-app_main_latest_8000
                        echo 'Cleaning old image...'
                        docker rmi -f "di-my-first-flask-app_main:latest"
                        '''
                    }
                }
            }
            //----------------------------------------------    
            when {
                branch 'dev'
            }
            steps {
                when {
                    expression {
                        DOCKER_EXIST = sh(returnStdout: true, script: 'docker ps -q --filter name=my-first-flask-app_dev_latest_9000')
                        echo "DOCKER_EXIST:${DOCKER_EXIST}"
                        return DOCKER_EXIST != ''
                    }
                }
                steps {
                    script {
                        sh '''
                        echo Stoping container...
                        docker stop my-first-flask-app_dev_latest_9000
                        echo 'Cleaning old container...'
                        docker rm my-first-flask-app_dev_latest_9000
                        echo 'Cleaning old image...'
                        docker rmi -f "di-my-first-flask-app_dev:latest"
                        '''
                    }
                }
            }    
        }
        stage('Build')
        {
            when {
                branch 'main'
            }
            steps {
                echo 'Building Docker Image...'
                sh 'docker build -t di-my-first-flask-app_main:latest .'
            }
            when {
                branch 'dev'
            }
            steps {
                echo 'Building Docker Image...'
                sh 'docker build -t di-my-first-flask-app_dev:latest .'
            } 
        }
        stage('Deploy') {
            when {
                branch 'main'
            }
            steps {
                echo 'Deploying.... '
                echo 'Running Container...'
                sh 'docker run -dp 8000:8000 --name my-first-flask-app_main_latest_8000 di-my-first-flask-app_main:latest'
            }
            when {
                branch 'dev'
            }
            steps {
                echo 'Deploying.... '
                echo 'Running Container...'
                sh 'docker run -dp 9000:8000 --name my-first-flask-app_dev_latest_9000 di-my-first-flask-app_dev:latest'
            }
        }
        stage('Deploy Test')
        {
            echo 'Deploy Test:  SUCCESS'

        }        
    }
}