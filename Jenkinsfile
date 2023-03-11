pipeline {
    agent any  
    // environment {
    //     container_name = "my-first-flask-app"
    //     image_name = "di-my-first-flask-app"
    //     imageo_tag = "latest"
    //     app_port = "8000"
    //     target = "main" 
    //     final_container_name = "${container_name}-${target}-${image_tag}-${app_port}"
    //     "my-first-flask-app_main_latest_8000"
    //     "di-my-first-flask-app_main:latest"
    //     final_image_name = "${image_name}:${image_tag}"                
    // }    
    stages {
        stage('Building Main Branch')
        {
            when { branch 'origin/main' }
            stages {
                stage('Stop and Clean') {
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
                stage('Build ') {
                    steps {                
                        echo 'Building Docker Image...'
                        sh 'docker build -t di-my-first-flask-app_main:latest .'
                    }
                }        
                stage('Deploy') {
                    steps {
                        echo 'Deploying.... '
                        echo 'Running Container...'
                        sh 'docker run -dp 8000:8000 --name my-first-flask-app_main_latest_8000 di-my-first-flask-app_main:latest'
                    }
                }  
            }
        }
        stage('Building Dev Branch')
        {
            when { branch 'origin/dev' }
            stages {
                stage('Stop and Clean') {
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
                stage('Build ') {
                    steps {                
                        echo 'Building Docker Image...'
                        sh 'docker build -t di-my-first-flask-app_dev:latest .'
                    }
                }        
                stage('Deploy') {
                    steps {
                        echo 'Deploying.... '
                        echo 'Running Container...'
                        sh 'docker run -dp 9000:8000 --name my-first-flask-app_dev_latest_9000 di-my-first-flask-app_dev:latest'
                    }
                }  
            }
        }            
    }
}