# checkov:skip=CKV_AWS_145: "Skipping KMS encryption due budget limitations"
# checkov:skip=CKV2_AWS_62: "Skipping due budget limitations"
resource "aws_s3_bucket" "bucket" {
  bucket        = var.bucket_name
  force_destroy = false
  # checkov:skip=CKV_AWS_18: Logging is omitted because this is handled by other code.
  # checkov:skip=CKV2_AWS_61: "S3 bucket used for demonstration purposis only"
  # checkov:skip=CKV_AWS_144: Cross-region replication is not required for demonstration purposis only"
}

resource "aws_s3_bucket_versioning" "enabled" {
  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  bucket = aws_s3_bucket.bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket                  = aws_s3_bucket.bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
