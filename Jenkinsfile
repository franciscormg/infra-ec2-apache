pipeline {
    agent any

    environment {
        AWS_REGION = 'us-east-1'
    }

    stages {

        stage('Terraform Init') {
            steps {
                sh '''
                    docker run --rm \
                    -v $PWD:/workspace \
                    -v /var/lib/jenkins/.aws:/root/.aws \
                    -w /workspace \
                    hashicorp/terraform:1.6 init
                '''
            }
        }

        stage('Terraform Plan') {
            steps {
                sh '''
                    docker run --rm \
                    -v $PWD:/workspace \
                    -v /var/lib/jenkins/.aws:/root/.aws \
                    -w /workspace \
                    hashicorp/terraform:1.6 plan -out=tfplan
                '''
            }
        }

        stage('Terraform Apply') {
            steps {
                sh '''
                    docker run --rm \
                    -v $PWD:/workspace \
                    -v /var/lib/jenkins/.aws:/root/.aws \
                    -w /workspace \
                    hashicorp/terraform:1.6 apply -auto-approve tfplan
                '''
            }
        }

        stage('Mostrar IP pública') {
            steps {
                script {
                    def ip = sh(
                        script: '''
                            docker run --rm \
                            -v $PWD:/workspace \
                            -v /var/lib/jenkins/.aws:/root/.aws \
                            -w /workspace \
                            hashicorp/terraform:1.6 output -raw ec2_public_ip
                        ''',
                        returnStdout: true
                    ).trim()

                    echo "EC2 levantada en IP: ${ip}"
                    echo "Prueba en tu navegador: http://${ip}"
                }
            }
        }
    }
}
