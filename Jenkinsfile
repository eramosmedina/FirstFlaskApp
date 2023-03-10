pipeline {
    agent any
    parameters {
        string(name: 'container_name', defaultValue: 'my-first-flask-app', description: 'Nombre del contendor')
        string(name: 'image_name', defaultValue: 'di-my-first-flask-app', description: 'Nombre de la imagen')
        string(name: 'image_tag', defaultValue: 'latest', description: 'Etiqueta de la imagen')
        string(name: 'app_port', defaultValue: '8000', description: 'Puerto para publicar la app del contendor')
    }
    environment {
        final_container_name = "${container_name}-${image_tag}-${app_port}"
        final_image_name = "${image_name}:${image_tag}"
                
    }    
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