data "template_file" "init-script" {
  template = file("./scripts/init.cfg")

  vars = {
    REGION = var.aws_region
  }
}

data "template_file" "shell-scripts" {
  template = file("./scripts/volumes.sh")
  vars = {
    DEVICE = var.INSTANCE_DEVICE_NAME
  }
}

data "template_cloudinit_config" "couldinit-example" {

  gzip          = false
  base64_encode = false
  part {
    filename     = "init.cfg"
    content_type = "text/could-config"
    content      = data.template_file.init-script.rendered
  }

  part {
    content      = data.template_file.shell-scripts.rendered
    content_type = "text/x-shellscript"
  }
}