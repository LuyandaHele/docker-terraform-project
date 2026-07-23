# creating an s3 bucket
resource "aws_s3_bucket" "env_file_bucket"{
    bucket = "${var.project_name}-${var.environment}-s3"
}

#uploading the environment file from the local computer into the s3 bucket
resource "aws_s3_object" "upload_env_file"{
    bucket = aws_s3_bucket.env_file_bucket.id
    key    = var.env_file_name
    source = "./${var.env_file_name}"
}