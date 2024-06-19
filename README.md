## Apps used in this repository:
1. [Geeky](https://github.com/bhavyansh001/geeky_01) [Full-stack Dynamic Mathematical game]
2. [Tattle](https://github.com/bhavyansh001/tattle) [Full-stack Real-time Chat app]
3. [EventApp](https://github.com/bhavyansh001/EventApp) [Full-stack Event Management app]
4. [Contained Rails](https://github.com/bhavyansh001/contained_rails) [Multi container Dockerized (docker-compose) application]
5. [Articles API](https://github.com/bhavyansh001/rails_api_myarticles) [REST API Backend]

## Tools used in this repository:
Linux, Docker, Bash scripting, AWS, Microservices, Ansible, Terraform

## Project1:
- This project uses AWS CLI to perform EC2 instance related tasks and a bash script to minimize the time it takes for developers to deploy rails code.
Script is based on [Deploy guide by Gorails](https://gorails.com/deploy/ubuntu/22.04)

Link to blog for walkthrough with screenshots:
[Project1](https://diversepixel.medium.com/deploying-geeky-using-aws-cli-devops-project-01-5f0a9035e70b) 

## Project2:
- The second project is deploying a Docker image on Amazon ECS cluster.
Docker Image pushed to [Docker Hub](https://hub.docker.com/r/bhavyansh001/contained_rails)
The rails application lives [here](https://github.com/bhavyansh001/contained_rails) (uses branch `main` for ECS deployment)
[Containerd_Rails uses `Docker Compose` when as a multi-container application]

Link to my blog for walkthrough, covering ECR, ECS and the steps to follow:
[Project2](https://diversepixel.medium.com/deploying-a-rails-application-on-amazon-ecs-devops-project-02-c128fb8b8884) 

## Project3:
- Rails application deployed based on Microservices architecture. Used different instance for running `postgres database` and `redis cache service`.
Learnt about configuration files and setting up secure remote connections.
Deployed application: [Geeky](https://github.com/bhavyansh001/geeky_01)
[Edit after Project 4]
We can also use Ansible for microservice deployment, automating a large part of this setup

Link to blog for walkthrough with screenshots:
[Project3](https://diversepixel.medium.com/microservices-on-aws-ec2-devops-project-03-a434c92763e5) 

## Project4:
- Ansible to deploy Rails application
Deployed application: [Tattle](https://github.com/bhavyansh001/tattle)
Contains a shell script to be run to set env vars for application deployment, then the main playbook can be run.

Link to blog for walkthrough with screenshots:
[Project4](https://diversepixel.medium.com/rails-deployment-using-ansible-devops-project-04-945588169942) 

## Project5:
- Terraform & Ansible: Complete Microservice Infrastructure Automation
Deployed application: [Tattle](https://github.com/bhavyansh001/tattle)
Any rails developer can make use of this project to deploy their application very quickly, setting up the infrastructure and configuring the instances.

Link to blog for walkthrough with screenshots:
[Project5](https://diversepixel.medium.com/terraform-iac-ansible-devops-project-05-4353802be1a3)