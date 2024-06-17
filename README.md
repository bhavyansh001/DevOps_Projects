## Project1:
- This project uses AWS CLI to perform EC2 instance related tasks and a bash script to minimize the time it takes for developers to deploy rails code.
Script is based on [Deploy guide by Gorails](https://gorails.com/deploy/ubuntu/22.04)

Link to my blog for walkthrough:
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

Link to my blog:
[Project3](https://diversepixel.medium.com/microservices-on-aws-ec2-devops-project-03-a434c92763e5) 

## Project4:
- Ansible to deploy Rails application
Deployed application: [Tattle](https://github.com/bhavyansh001/tattle)
Contains a shell script to be run to set env vars for application deployment, then the main playbook can be run.

Link to my blog:
[Project4](https://diversepixel.medium.com/rails-deployment-using-ansible-devops-project-04-945588169942) 