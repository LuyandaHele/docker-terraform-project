# storing the terraform state file in an s3 bucket  and using a dynamodb table to lock the state file to avoid current state file modification
terraform {
  backend "s3" {
    bucket         = "louie-s3-terraform-remote-state-file" 
    key            = "docker-terraform-project/terraform.tfstate"
    region         = "us-east-1"
    profile        = "terraform-user"
    use_lockfile   = true                                           
  }
}
