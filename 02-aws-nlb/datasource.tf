# Aviatrix State (Phase I provisioning)
data "terraform_remote_state" "ingress_infra" {
  backend = "local"
  config = {
    path = "../../aws-psf-ingress/terraform.tfstate"
  }
}

data "aviatrix_gateway" "psf_gw" {
  gw_name = data.terraform_remote_state.ingress_infra.outputs.psf_gateway_aws.gw_name
}

data "aws_subnet" "psf_subnet_1" {
  filter {
    name   = "tag:Name"
    values = ["aviatrix-${data.terraform_remote_state.ingress_infra.outputs.psf_gateway_aws.gw_name}"]
  }
}

data "aws_subnet" "psf_subnet_2" {
  filter {
    name   = "tag:Name"
    values = ["aviatrix-${data.terraform_remote_state.ingress_infra.outputs.psf_gateway_aws.gw_name}-hagw"]
  }
}
