pipeline {
    agent any
    stages {
        stage("AWS Demo") {
            steps {
                withCredentials([
                    [
                        $class: 'AmazonWebServicesCredentialsBinding',
                        credentialsId: 'aws_credential',
                        accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                        secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                    ]
                ]) {
                    sh "aws s3 ls"
                }
            }
        }ß
        stage("Building AMI WITH PACKER") {
            steps {
                withCredentials([
                    [
                        $class: 'AmazonWebServicesCredentialsBinding',
                        credentialsId: 'aws_credential',
                        accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                        secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                    ]
                ]) {
                    sh "packer init aws-ami-v1.pkr.hcl"
                    sh "packer build aws-ami-v1.pkr.hcl"
                }
            }
        }
    }
}