pipeline {
    agent any  
    environment {
        container_name = "my-first-flask-app"
        image_name = "di-my-first-flask-app"
        image_tag = "latest"
        app_port = "8000"
        final_container_name = "${container_name}-${image_tag}-${app_port}"
        final_image_name = "${image_name}:${image_tag}"                
    }    
    stages {
        stage('Building Main Branch')
        {
            when { branch 'main' }
            stages {
                stage('Stop and Clean') {
                    when {
                        expression {
                            DOCKER_EXIST = sh(returnStdout: true, script: 'docker ps -q --filter name=${final_container_name}')
                            echo "DOCKER_EXIST:${DOCKER_EXIST}"
                            return DOCKER_EXIST != ''
                        }
                    }
                    steps {
                        script {
                            sh '''
                            echo Stoping container...
                            docker stop ${final_container_name}
                            echo 'Cleaning old container...'
                            docker rm ${final_container_name}
                            echo 'Cleaning old image...'
                            docker rmi -f ${final_image_name}
                            '''
                        }
                    }
                }  
            }

        }
        stage('Building Dev Branch')
        {
            when { branch 'dev' }
            stages {
                stage('Stop and Clean') {
                    when {
                        expression {
                            DOCKER_EXIST = sh(returnStdout: true, script: 'docker ps -q --filter name=${final_container_name}')
                            echo "DOCKER_EXIST:${DOCKER_EXIST}"
                            return DOCKER_EXIST != ''
                        }
                    }
                    steps {
                        script {
                            sh '''
                            echo Stoping container...
                            docker stop ${final_container_name}
                            echo 'Cleaning old container...'
                            docker rm ${final_container_name}
                            echo 'Cleaning old image...'
                            docker rmi -f ${final_image_name}
                            '''
                        }
                    }
                }  
            }

        } 
        
        stage('Build ') {
            steps {                
                echo 'Building Docker Image...'
                sh 'docker build -t ${final_image_name} .'
            }
        }
        
        stage('Deploy') {
            steps {
                echo 'Deploying.... '
                echo 'Running Container...'
                sh 'docker run -dp ${app_port}:8000 --name ${final_container_name} ${final_image_name}'
            }
        }
        
        //stage('Deploy Tests') {
        //    steps {
        //        echo 'Testing Deploy'
        //        echo 'test with curl'
        //    }
        //}
    }
}