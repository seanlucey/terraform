resource "random_id" "random" {
  byte_length = 8
}

resource "aws_iam_role" "replication" {
  name = "s3-bucket-replication-${random_id.random.hex}"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "s3.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}
