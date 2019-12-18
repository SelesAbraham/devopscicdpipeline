# TestDevOpsPipeline
To automatically deploy and configure containerized elasticsearcg on the Kubernetes (Minikube). 
 - CI/CD pipeline with fully automated deployment and configuration of Elasticsearch
 - Git configured with Web Hook which triggers Jenkins Job
 - Jenkins job automates the build, test and deployment of Elasticsearch simulated in a local environment using Jenkinsfile (Groovy)
 - Configuration of all elasticsearch component is decoipled using ConfigMaps (any changes to configmap triggers new deployment)
 
 Next steps after all is configured and running (Pipeline set): 
 - Test cases (Infrastructural, functional and performance test)
 - Servuce provisioning orchestrated via Kubernetes (YAML) 
 
