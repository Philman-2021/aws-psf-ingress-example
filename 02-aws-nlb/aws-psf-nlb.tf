resource "aws_lb" "psf_nlb" {
  name                       = "avx-psf-nlb"
  internal                   = false
  load_balancer_type         = "network"
  subnets                    = [data.aws_subnet.psf_subnet_1.id, data.aws_subnet.psf_subnet_2.id]
  enable_deletion_protection = false # Set to true for Prod
}

resource "aws_lb_target_group" "psf_nlb_tg" {
  name        = "avx-psf-nlb-tg"
  port        = var.psf_nlb_port
  protocol    = var.psf_nlb_protocol
  target_type = "instance"
  vpc_id      = data.terraform_remote_state.ingress_infra.outputs.spoke_aws_1.vpc.vpc_id
}

resource "aws_lb_target_group_attachment" "psf_nlb_attachment_1" {
  target_group_arn = aws_lb_target_group.psf_nlb_tg.arn
  target_id        = data.aviatrix_gateway.psf_gw.cloud_instance_id
  port             = var.psf_nlb_port
}

resource "aws_lb_target_group_attachment" "psf_nlb_attachment_2" {
  target_group_arn = aws_lb_target_group.psf_nlb_tg.arn
  target_id        = data.aviatrix_gateway.psf_gw.peering_ha_cloud_instance_id
  port             = var.psf_nlb_port
}

resource "aws_lb_listener" "psf_nlb_listener" {
  load_balancer_arn = aws_lb.psf_nlb.arn
  port              = var.psf_nlb_port
  protocol          = var.psf_nlb_protocol
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.psf_nlb_tg.arn
  }
}