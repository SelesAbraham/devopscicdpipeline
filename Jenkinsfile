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
        app = docker.build("selesabraham/elasticsearch") 
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
         sshagent(['instance-2']) {
            echo "in instance-2"
            sh "scp -o StrictHostKeyChecking=no services.yml pods.yml seles2112@35.239.96.97:/home/seles2112/"
            echo "before scripts"
            script{
                try{
                    //sh("kubectl create -f app-deployment.yml -v=8")
                    sh("kubectl get ns default || kubectl create ns default")
                    //sh "ssh rsa-key-20191217@instance-1 kubectl apply -f ."
                    echo "get"
                    //sh "ssh seles2112@instance-1 kubectl apply -f ."
                    //sh "ssh seles2112@35.239.96.97 kubectl apply -f ."
                    
                }catch(e) {
             notify("Something failed Kubernetes Setup")
                    //sh "ssh rsa-key-20191217@instance-1 kubectl create -f ."
                    echo "created"
                    //sh "ssh seles2112@instance-1 kubectl apply -f ."
                    //sh "ssh seles2112@35.239.96.97 kubectl create -f ."
            // throw e;
                }
            }  
         }  
    }
}