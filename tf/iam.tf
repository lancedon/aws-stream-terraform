
resource "aws_iam_policy" "administrator" {
  name        = "adm"
  path        = "/"
  description = "adm"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "iam:*"
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role" "lambda-kinesis-role" {
  name = "lambda-kinesis-role"
  description = "Allows Lambda functions to call AWS services on your behalf."
  max_session_duration = 3600
 
  managed_policy_arns = [
          "arn:aws:iam::aws:policy/AdministratorAccess",
        ]

  assume_role_policy = jsonencode(
            {
               Statement = [
                   {
                       Action    = "sts:AssumeRole"
                       Effect    = "Allow"
                       Principal = {
                           Service = "lambda.amazonaws.com"
                        }
                    },
                ]
               Version   = "2012-10-17"
            }
        ) 

}
