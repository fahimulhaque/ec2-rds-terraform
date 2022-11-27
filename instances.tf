# Public Facing Web server
resource "aws_instance" "external_web" {
  count                  = var.external_web_instance_count
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = module.vpc.public_subnets[(count.index % var.vpc_subnet_count)]
  vpc_security_group_ids = [aws_security_group.external-web-sg.id]

  user_data = templatefile("${path.module}/startup_script.tftpl", {})

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-external-web-${count.index}"
  })

}
# Internal Web server
resource "aws_instance" "internal_web" {
  count                  = var.internal_web_instance_count
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = module.vpc.public_subnets[(count.index % var.vpc_subnet_count)]
  vpc_security_group_ids = [aws_security_group.internal-web-sg.id]

  user_data = templatefile("${path.module}/startup_script_internal.tftpl", {})

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-internal-web-${count.index}"
  })
  key_name = aws_key_pair.kp.key_name
}

#Invoke Startup script