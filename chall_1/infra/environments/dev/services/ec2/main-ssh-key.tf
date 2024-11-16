resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = file(data.external.new_ssh_key_pair_path.result["private"])
}
