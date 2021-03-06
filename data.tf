data "aws_ami" "bastionhostPackerAmi" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name ="name"
    values =["amzn2-ami-hvm-2.*-x86_64-gp2"]
  }
}

# data "aws_iam_policy_document" "instance-assume-role-policy" {
#   statement {
#     actions = ["sts:AssumeRole"]

#     principals {
#       type        = "Service"
#       identifiers = ["ec2.amazonaws.com"]
#     }
#   }
# }
# resource "random_string" "projectId" {
#   length  = 10
#   special = false
#   upper   = false
#   number  = false
# }
# resource "random_integer" "randomSshPortIntern" {
#   min = 13000
#   max = 14000
# }
# resource "random_integer" "randomDockerPortIntern" {
#   min = 15001
#   max = 16000
# }
# resource "random_integer" "randomSshPortExtern" {
#   min = 12000
#   max = 13000
# }
# resource "random_integer" "randomDockerPortExtern" {
#   min = 14001
#   max = 15000
# }
# data "template_file" "connectDockerSocketIntern" {
#   template = "${file("tpl/connectDocker.tpl")}"

#   vars {
#     random_port      = "${random_integer.randomDockerPortIntern.result}"
#     userid           = "${lower(random_string.projectId.result)}"
#     host_fqdn        = "${aws_route53_record.dockerhost_masterintern.fqdn}"
#     bastionhost_fqdn = "${element(data.terraform_remote_state.baseInfra.bastion_dns,0)}"
#     workspace        = "${terraform.workspace}"
#   }
# }
# data "template_file" "startSshDockerInternScript" {
#   template = "${file("tpl/start_ssh.tpl")}"

#   vars {
#     random_port      = "${random_integer.randomSshPortIntern.result}"
#     userid           = "${lower(random_string.projectId.result)}"
#     host_fqdn        = "${aws_route53_record.dockerhost_masterintern.fqdn}"
#     bastionhost_fqdn = "${element(data.terraform_remote_state.baseInfra.bastion_dns,0)}"
#     workspace        = "${terraform.workspace}"
#   }
# }
# data "template_file" "installscript_master_intern" {
#   template = "${file("tpl/installdockermaster.tpl")}"

#   vars {
#     file_system_id = "${element(data.terraform_remote_state.baseInfra.efs_filesystem_id,0)}"
#     efs_directory  = "/efs"
#     project_id     = "${local.projectId}-intern"
#     user_id        = "${lower(random_string.projectId.result)}"
#     public_key     = "${trimspace(tls_private_key.private_key_dockercluster.public_key_openssh)}"
#   }
# }
# data "template_file" "installscript_worker_intern" {
#   template = "${file("tpl/installdockerworker.tpl")}"

#   vars {
#     file_system_id = "${element(data.terraform_remote_state.baseInfra.efs_filesystem_id,0)}"
#     efs_directory  = "/efs"
#     project_id     = "${local.projectId}-intern"
#     master_ip      = "${aws_instance.internerDockerhostMaster.private_ip}"
#   }

#   depends_on = ["aws_instance.internerDockerhostMaster"]
# }