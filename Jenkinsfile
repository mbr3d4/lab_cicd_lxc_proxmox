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
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    dir("tf") {
                        sh 'terraform apply --auto-approve'
                    }
                }
            }
        }
       stage("Esperando pelos Containers"){
            steps{
                sh 'sleep 60'
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