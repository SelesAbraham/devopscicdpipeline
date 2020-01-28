node {
    def app

    stage('Clone repository') {
        checkout scm
        echo "Checkout successful"
    }

    stage('Build image') {
        app = docker.build("selesabraham/elasticsearch") 
    }

    stage('Test image') {
        app.inside {
            sh 'echo "Tests suceesully passed"'
        }
    }

    stage('Push image') {
        docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
        }
    }

     stage('Kubernetes Setup'){
         sshagent(['instance-2']) {
            sh "scp -o StrictHostKeyChecking=no services.yaml pods.yaml quickstart-kibana.yaml ConfigMap.yaml deployment.yaml seles2112@35.202.175.54:/home/seles2112/"
            script{
                try{
                    sh "ssh seles2112@35.202.175.54 kubectl apply -f https://download.elastic.co/downloads/eck/1.0.0-beta1/all-in-one.yaml"
                    sh "ssh seles2112@35.202.175.54 kubectl apply -f ."
                   // sh "kubectl get deployments -n kube-system"
                    
                }catch(e) {
                    sh "ssh seles2112@35.202.175.54 kubectl create -f ."
                }
            }  
         }  
    }
} 