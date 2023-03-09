pipeline {
    agent any
    parameters {
        string(name: 'container_name', default_value: 'my-first-flask-app', description: 'Nombre del contendor')
        string(name: 'image_name', default_value: 'di-my-first-flask-app', description: 'Nombre de la imagen')
        string(name: 'image_tag', default_value: 'latest', description: 'Etiqueta de la imagen')
        string(name: 'app_port', default_value: '8000', description: 'Puerto para publicar la app del contendor')
    }
    environment {
        final_name = "${container_name}${image_tag}${app_port}"
        final_image_name = "${image_name}:${image_tag}"
                
    }
    
    stages {

        stage('Checkout') {
            steps { 
                checkout scmGit(branches: [[name: '*/main']], 
                extensions: [], 
                userRemoteConfigs: [[url: 'https://github.com/eramosmedina/FirstFlaskApp.git']])
            }
        }

        stage('Stop and Clean') {
            when {
                expression {
                    DOCKER_EXIST = sh(returnStdout: true, script: 'echo "$(docker ps -q --filter name=${final_name})"')
                    return DOCKER_EXIST != ''
                }
            }
            steps {
                script {
                    sh '''
                    echo Stoping container...
                    docker stop ${final_name}
                    echo 'Cleaning old container...'
                    docker rm ${final_name}
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
                sh 'docker run -dp ${app_port}:8000 --name ${final_name} ${final_image_name}'
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