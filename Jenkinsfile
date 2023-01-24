pipeline {
    agent any
       
    stages {
       stage('Terraform init'){
            steps{
                dir("tf") {
                    sh 'terraform init'
               }
            }
        }
       stage('Terraform apply'){
            steps{
                dir("tf") {
                    sh 'terraform apply --auto-approve'
               }
            }
        }
       stage('Ansible Docker'){
            steps{
                dir("ansible") {
                    sh 'ansible-playbook playbook.yml -i hosts'
               }
            }
        }
    }
}