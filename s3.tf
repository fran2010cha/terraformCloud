resource "aws_s3_bucket" "cerberus_buket" {
  bucket = local.s3-sufix

}