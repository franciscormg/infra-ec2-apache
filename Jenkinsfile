pipeline {
    agent {
        docker {
            image 'hashicorp/terraform:1.6'
            args '-u root:root -v /var/lib/jenkins/.aws:/root/.aws'
        }
    }

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
                sh 'terraform plan -out=tfplan'
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve tfplan'
            }
        }

        stage('Mostrar IP pública') {
            steps {
                script {
                    def ip = sh(script: "terraform output -raw ec2_public_ip", returnStdout: true).trim()
                    echo "EC2 levantada en IP: ${ip}"
                    echo "Prueba en tu navegador: http://${ip}"
                }
            }
        }
    }
}
