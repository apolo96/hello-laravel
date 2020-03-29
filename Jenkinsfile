pipeline {
    agent {
        docker { 
            image 'composer' 
        }
    }
    stages {
        stage('Test') {
            steps {
                sh 'composer install --optimize-autoloader --no-dev'
            }
        }
    }
}
