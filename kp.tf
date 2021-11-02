resource "tls_private_key" "main" {
  count = var.GenerateNewKeyPair ? 1 : 0

  algorithm = "RSA"
}

resource "null_resource" "main" {
  count = var.GenerateNewKeyPair ? 1 : 0

  provisioner "local-exec" {
    command = "echo \"${tls_private_key.main[count.index].private_key_pem}\" > ${var.KeyPairName}.pem"
  }

  provisioner "local-exec" {
    command = "chmod 600 ${var.KeyPairName}.pem"
  }

}

resource "aws_key_pair" "main" {
  count = var.GenerateNewKeyPair ? 1 : 0

  key_name   = var.KeyPairName
  public_key = tls_private_key.main[count.index].public_key_openssh
}
