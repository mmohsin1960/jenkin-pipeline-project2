pipeline {
    agent any
    stages {
        stage("Git Checkout docker file") {
            steps {
                git branch: 'main', url: 'https://github.com/mmohsin1960/Jenkin-pipeline-project1.git'
                sh 'pwd'
                sh 'ls'
            }
        }
        
        stage("Build Image") {
            steps {
                sh 'docker image build -t $JOB_NAME:v1.BUILD_ID .'
                sh 'docker image tag $JOB_NAME:v1.BUILD_ID mohsin1056/$JOB_NAME:v1.$BUILD_ID'
                sh 'docker image tag $JOB_NAME:v1.BUILD_ID mohsin1056/$JOB_NAME:latest'
            }
        }
        
        stage("Push Image to Docker Hub") {
            steps {
                withCredentials([string(credentialsId: 'dock-passwrd', variable: 'dockerpas')]) {
                    sh 'docker login -u mohsin1056 -p $dockerpas'
                    sh 'docker image push mohsin1056/$JOB_NAME:v1.$BUILD_ID'
                    sh 'docker image push mohsin1056/$JOB_NAME:latest'
                    sh 'docker rmi $JOB_NAME:v1.BUILD_ID mohsin1056/$JOB_NAME:v1.$BUILD_ID mohsin1056/$JOB_NAME:latest'
                }
            }
        }
        
        stage("Deploy to Prod Server") {
            steps {
               
                
                sshagent(['prodserver']) {
                    sh "ssh -o StrictHostKeyChecking=no ubuntu@10.0.1.230 docker rm -f mywebapp"
                    sh "ssh -o StrictHostKeyChecking=no ubuntu@10.0.1.230 docker rmi -f mywebapp"
                    sh "ssh -o StrictHostKeyChecking=no ubuntu@10.0.1.230 docker run -itd --name mywebapp -p 9001:80 mohsin1056/task"
                }
            }
        }
    }
}
