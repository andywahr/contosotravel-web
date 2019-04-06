ContosoTravel Web for Arkhitekton
==================

| Component            | Build Status                                                                                                                                                                                | 
| -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | 
| Infrastructure (this Repo) | [![Build Status](https://dev.azure.com/contosotravel/Infrastructure/_apis/build/status/andywahr.contosotravel-web?branchName=master)](https://dev.azure.com/contosotravel/Infrastructure/_build/latest?definitionId=1&branchName=master) | (this one) |
| [.Net (Core and Full Framework)](https://github.com/andywahr/contosotravel-web-dotnet)     | [![Build Status](https://dev.azure.com/contosotravel/Infrastructure/_apis/build/status/andywahr.contosotravel-web-dotnet?branchName=master)](https://dev.azure.com/contosotravel/Infrastructure/_build/latest?definitionId=2&branchName=master) DataLoader Publish: [![Build Status](https://dev.azure.com/contosotravel/Infrastructure/_apis/build/status/dataloader-publish?branchName=master)](https://dev.azure.com/contosotravel/Infrastructure/_build/latest?definitionId=5&branchName=master) | 
| [Node JS](https://github.com/andywahr/contosotravel-web-nodejs)   | [![Build Status](https://dev.azure.com/contosotravel/Infrastructure/_apis/build/status/andywahr.contosotravel-web-nodejs?branchName=master)](https://dev.azure.com/contosotravel/Infrastructure/_build/latest?definitionId=3&branchName=master)   | 
| [Load Test](https://github.com/andywahr/contosotravel-web-test) | [![Build Status](https://dev.azure.com/contosotravel/Infrastructure/_apis/build/status/andywahr.contosotravel-web-test?branchName=master)](https://dev.azure.com/contosotravel/Infrastructure/_build/latest?definitionId=4&branchName=master) Artillery.io LoadTest Publish [![Build Status](https://dev.azure.com/contosotravel/Infrastructure/_apis/build/status/test-publisher?branchName=master)](https://dev.azure.com/contosotravel/Infrastructure/_build/latest?definitionId=6&branchName=master) | 

ContosoTravel Web is a simple Travel booking web example hosted in Azure, allowing for the creation of a contextual demonstration for a given environment.  The majority of the application platforms are implemented in atleast .Net Core and Node JS, with some targeted implementations in .Net Full Framework.

![Image of ContosoTravel](./bigPicture.png)

 How to get started
 ----------------
 - Configure [Visual Studio Code and Terraform](https://docs.microsoft.com/en-us/azure/terraform/terraform-vscode-extension)
 - Getting started with [Terraform on Azure](https://docs.microsoft.com/en-us/azure/terraform/)
 - Documentation for [Azure Provider for Terraform](https://www.terraform.io/docs/providers/azurerm/)

What is this when deployed
-----------------
Once a ContosoTravel Solution is deployed by [Arkhitekton](https://arkhitekton.azurewebsites.net):
* Resource Group is created in the selected Azure Subscription
* DevOps Project is created in the selected Azure DevOps Organization
* Up to 4 Build Pipelines are created
  * Infrastructure Pipeline - Executes Terraform to deploy Azure Infrastructure and kicks off the Data Loader
  * Web Pipeline - After Infrastructure, Builds and Deploys the selected Web Site
  * Service Pipeline (optional) - After Infrastructure, Builds and Deploys the selected Backend platform (if Monolith is choosen, this is skipped)
  * LoadTest Pipeline - After Web, Deploys the LoadTest container as [Azure Container Instnace](https://azure.microsoft.com/en-us/services/container-instances/) and runs Load Tests from 3 different US Regions
* The DataLoader is in the .Net repository, and is repsonsible for configuring the Data choice (create database, deploy schema, permission, run base data load) 
