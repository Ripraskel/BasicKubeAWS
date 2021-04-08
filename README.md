# BasicKubeAWS

## Usage

Add a remote backend to the `terraform.tf` file, eg:
```
  backend "s3" {
    bucket = "<state-bucket-name>"
    key    = "basic-eks-cluster-on-aws"
    region = "eu-west-2"
  }
```
replace `<state-bucket-name` with the name of your state bucket.
 

