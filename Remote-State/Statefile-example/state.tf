terraform {
	backend "s3" {
		bucket = "bibin-terrafrom-state"
		key    = "remotestate/terraform.tfstate"
		region = "us-east-1"
	}
}
