# WordpressDemo

For Installation and Deployments please review:

https://medium.com/@ujala2yz/deploy-wordpress-and-mysql-on-k8s-with-the-help-of-custom-build-images-d890086e6032

# Ujala-Project

# AWS SageMaker

Before successfully runing this code, you may need to fill in your personal configurations (e.g. S3 bucket name, AWS access key, aws object key).

## Pre-requisite

* Python3
* AWS SDK
* Docker
* Terraform

I will focus on building a pipeline using a model trained on SageMaker bringing your own container/algorithm. 

Applying DevOps practices to Machine Learning (ML) workloads is a fundamental practice to ensure models are deployed using a reliable and consistent process as well as to increase overall quality.   DevOps is not about automating the deployment of a model.  DevOps is about applying practices such as Continuous Integration(CI) and Continuous Delivery(CD) to the model development lifecycle.  CI/CD relies on automation; however, automation alone is not synonymous with DevOps or CI/CD.  

In this section, you will create a deployment pipeline utilizing AWS Development Services and SageMaker to demonstrate how CI/CD practices can be applied to machine learning workloads.

In this lab, the use case we will focus on will be bring-your-own-algorithm for training and deploying on SageMaker.

-------
## Prerequisite

1) AWS Account
2) Please use North Virginia, **us-east-1** for this workshop


------

## Overview

This lab will walk you through the steps required to:

• Setup a base pipeline responsible for orchestration of workflow to build and deploy custom ML models to target environments

•	Create logic, in this case Lambda functions, to execute the necessary steps within the orchestrated pipeline required to build, train, and host ML models in an end-to-end pipeline

For this process, I will use the steps outlined in this document combined with two [CloudFormation](https://aws.amazon.com/cloudformation/) templates to create your pipeline.   CloudFormation is an AWS service that allows you to model your entire infrastructure using YAML/JSON templates.   The use of CloudFormation is included not only for  simplicity in lab setup but also to demonstrate the capabilities and benefits of Infrastructure-as-Code(IAC) and Configuration-as-Code(CAC).  We will also utilize SageMaker Notebook Instances as our lab environment to ensure a consistent experience.

---

## Phase 1:

In this step, you will launch a CloudFormation template using the file process_prep.yml provided as part of workshop materials.  This CloudFormation template accepts a single input parameter, **your-initials**,  that will be used to setup base components including:

-	**CodeCommit Repository:** CodeCommit repository that will act as our source code repository containing assets required for building our custom docker image.

-	**S3 Bucket for Lambda Function Code:** S3 bucket that we will use to stage Lambda function code that will be deployed by a secondary CloudFormation template executed in a later step.

-  **SageMaker Notebook Instance:**  We will use a SageMaker Notebook Instance as a local development environment to ensure a consistent lab environment experience. 

---

## Phase 2: Clean-Up

In addition to the steps for clean-up noted in your notebook instance, please execute the following clean-up steps.  Note: These steps can be automated and/or done programmatically but doing manual clean to enforce what was created during the workshop. 

1. Login to the [AWS Console](https://https://console.aws.amazon.com/) and enter your credentials   

2. Select **Services** from the top menu, and choose **Amazon SageMaker**

   **Notebook Instance**
   * Go to **Notebook Instances** on the left hand menu, select your notebook instance by selecting the radio button next to it.

   *  Select **Actions** and then **Stop** from the dropdown list

   **Endpoints**
   * Go to **Inference / Endpoints** on the left hand menu, click the radio button next to each endpoint. 

   * Select **Actions** and then **Delete**, then confirm delete hitting the **Delete** button. 

3. Select **Services** from the top menu, and choose **S3**

    * Delete all S3 buckets created for this workshop with the following naming convention: 
      - mlops-*
    
    * Click the box next to each bucket and click **Delete** -> confirm deletion


SageMaker supports two execution modes: _training_ where the algorithm uses input data to train a new model and _serving_ where the algorithm accepts HTTP requests and uses the previously trained model to do an inference (also called "scoring", "prediction", or "transformation").

The algorithm that we have built here supports both training and scoring in SageMaker with the same container image. It is perfectly reasonable to build an algorithm that supports only training _or_ scoring as well as to build an algorithm that has separate container images for training and scoring.

In order to build a production grade inference server into the container, we use the following stack to make the implementer's job simple:

1. __[nginx][nginx]__ is a light-weight layer that handles the incoming HTTP requests and manages the I/O in and out of the container efficiently.
2. __[gunicorn][gunicorn]__ is a WSGI pre-forking worker server that runs multiple copies of your application and load balances between them.
3. __[flask][flask]__ is a simple web framework used in the inference app that you write. It lets you respond to call on the `/ping` and `/invocations` endpoints without having to write much code.

## The Structure of the Sample Code

The components are as follows:

* __Dockerfile__: The _Dockerfile_ describes how the image is built and what it contains. It is a recipe for your container and gives you tremendous flexibility to construct almost any execution environment you can imagine. Here. we use the Dockerfile to describe a pretty standard python science stack and the simple scripts that we're going to add to it. See the [Dockerfile reference][dockerfile] for what's possible here.

* __local-test__: A directory containing scripts and a setup for running a simple training and inference jobs locally so that you can test that everything is set up correctly. See below for details.





