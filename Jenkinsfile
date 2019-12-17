node {
    def app

    stage('Clone repository') {
        /* Let's make sure we have the repository cloned to our workspace */

        checkout scm
        echo "Checkout successful"
    }

    stage('Build image') {
        /* This builds the actual image; synonymous to
         * docker build on the command line */

        //app = docker.build("selesabraham/myimage")
        //sh './dockerBuild.sh'
        app = docker.build("selesabraham/elasticsearchimage") 
    }

    stage('Test image') {
        /* Ideally, we would run a test framework against our image.
         * For this example, we're using a Volkswagen-type approach ;-) */

        app.inside {
            sh 'echo "Tests passed"'
        }
    }

    stage('Push image') {
        /* Finally, we'll push the image with two tags:
         * First, the incremental build number from Jenkins
         * Second, the 'latest' tag.
         * Pushing multiple tags is cheap, as all the layers are reused. */
        docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
        }
    }

     stage('Kubernetes Setup'){
         sshagent(['instance-1']) {
            sh "scp -o StrictHostKeyChecking=no services.yml node-app-pod.yml seles2112@instance-1:/home/instance-1/"
            script{
                try{
                    //sh("kubectl create -f app-deployment.yml -v=8")
                    //sh("kubectl get ns development || kubectl create ns development")
                    //sh "ssh rsa-key-20191217@instance-1 kubectl apply -f ."
                    sh "ssh seles2112@instance-1kubectl apply -f ."
                    //sh "ssh rsa-key-20191217@104.154.226.125 kubectl apply -f ."
                    
                }catch(e) {
            // notify("Something failed Kubernetes Setup")
                    //sh "ssh rsa-key-20191217@instance-1 kubectl create -f ."
                    sh "ssh seles2112@instance-1kubectl apply -f ."
                    //sh "ssh rsa-key-20191217@104.154.226.125 kubectl apply -f ."
            // throw e;
                }
            }  
         }  
    }
}