pipeline {
    agent any

    environment {
        // Define environment variables (use Jenkins credentials store for sensitive values)
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        // AWS_REGION            = 'us-east-1' // Specify the AWS region
        // TF_VAR_environment    = 'production' // Example of passing environment-specific variables
    }

    stages {
        stage('Checkout Code') {
            steps {
                // Pull the Terraform code from the Git repository
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                script {
                    // Initialize Terraform with a remote backend
                    bat 'terraform init -input=false'
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                script {
                    // Validate the Terraform configuration files
                    bat 'terraform validate'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    // Generate the execution plan and save it to a file for later use
                    // bat 'terraform plan -out=tfplan -input=false'
                    // bat 'terraform plan -no-color > tf.plan'
                    bat 'terraform plan -no-color | Tee-Object tf.plan'
                }
            }
        }

        stage('Manual Approval') {
            // when {
            //     expression {
            //         // Only require manual approval for production
            //         env.TF_VAR_environment == 'production'
            //     }
            // }
            steps {
                input message: 'Approve Terraform Changes?', ok: 'Proceed'
            }
        }

        stage('Terraform Apply') {
            steps {
                script {
                    // Apply the Terraform plan
                    bat 'terraform apply -input=false tfplan'
                }
            }
        }
    }

    post {
        always {
            // Clean up temporary files
            bat 'del -f tfplan'
        }
        success {
            echo 'Terraform changes applied successfully!'
        }
        failure {
            echo 'Terraform deployment failed. Please check the logs.'
        }
    }
}
