# URL shorterner
## Built using AWS API Gateway, Lambda functions (2), and DynamoDB

### Prerequisite
* An AWS Account
* A domain name that will function as your "short url" domain. Preferably this domain is one purchased in Route53. 
  * **Note**:  You will need to have the domain purchased before executing any steps to set the url shortener up.
* You will need the following software installed on your machine/in your local environment:
  * [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) - Note:  if you are a Mac user,
    I recommend using [tfenv](https://github.com/tfutils/tfenv) to install and manage terraform versions.
  * [Golang](https://go.dev/doc/install)
* Ensure your AWS credentials (with sufficient permissions) are [configured locally](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)--recommended
in $HOME/.aws/credentials--so that terraform will be able to successfully create IAM, API Gateway, DynamoDB, and Lambda resources.

### Installation
1. Clone this repo and then `cd` inside the project root:
```bash
git clone git@github.com:jdelnano/url-shortener.git
cd url-shortener
```
2. From the project root directory, create all AWS resources/infrastructure via `terraform`:
```bash
# I recommend running a `terraform plan` first, inspecting it to make sure
# terraform won't do anything unexpected in your AWS environment
terraform plan

# if all looks good, then apply!
terraform apply
```
3. That _should_ be it! If for some reason your API seems to not be active, you may need to go into
API Gateway and perform a 'deploy' of you API:

### Usage

#### Create a 'short' URL
To create a shortened url, execute the command below from any machine:
```
curl -X POST \
  'https://<your_domain>/' \
  --header 'Content-Type: application/json' \
  --data-raw '{"url": "https://example.com/shorten"}'
```

Example response:
```
https://<your_domain>/af43i
```

#### Use the 'short' URL
In a browser, copy and paste your shortened URL (e.g. `https://<your_domain>/af43i`) and see the magic work!
