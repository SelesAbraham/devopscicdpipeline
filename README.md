# TestDevOpsPipeline
To automatically deploy and configure containerized elasticsearcg on the Kubernetes (Minikube). 
As I do not have a powerful home laptop, I have made used of AWS student subscription instance for Jenkins and GCP Instance to host minikube.
The approach that I have followed is shortly described below:
1.	GitHub as SCM: These files are created and pushed into GitHub:
  •	docker file: This file is created for containerizing elastic search using the alpine version of libraries required, this ensures that the containers are lightweight. 
  •	pod.yml and service.yml: holds the configuration and infrastructural details for Kubernetes deploy using minikube
  •	Jenkinsfile: Written in Groovy follows a declarative pipeline setup, composing of stages like pull from SCM, build, test, deploy.
2.	Jenkins is hosted inside an AWS VM which deploys the elastic search containers to minikube pods hosted on the GCP cluster. This was necessary because minikube needs at least 2CPU machine, available only in GCP.
3.	All the necessary authentication and authorization are managed using Jenkins security credentials plugin
4.	A webhook is setup between SCM and Jenkins to continuously monitor changes in the file

 
 
