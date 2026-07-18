# create iam policy document. this policy allows the ecs service to assume a role.
data "aws_iam_policy_document" "assume_role_policy"{
    statement {
        actions = ["sts:AssumeRole"]

        principals {
            type = "Service"
            identifiers = ["ecs-tasks.amazonaws.com"]
            
        }
    }
}

# create iam policy document ( declaring the actions of what our policy can and cannot do)
data "aws_iam_policy_document" "ecs_task_execution_policy_document" {
  statement {
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]

    resources = ["*"]
  }

  statement {
    actions = [
      "s3:GetObject"
    ]

    resources = [
      "arn:aws:s3:::${var.project_name}-${var.environment}-s3/*"
    ]
  }

  statement {
    actions    = [
      "s3:GetBucketLocation"
    ]

    resources = [
      "arn:aws:s3:::${var.project_name}-${var.environment}-s3"
    ]
  }
}

#creating iam policy
resource "aws_iam_policy" "ecs_task_execution_policy"{
    name = "${var.project_name}-${var.environment}-ecs-task-exection-role-policy"
    policy = data.aws_iam_policy_document.ecs_task_execution_policy_document.json
}

#creating an iam role
resource "aws_iam_role" "ecs_task_execution_role"{
  name = "${var.project_name}-${var.environment}-ecs-task-exection-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

#attach ecs task execution policy to the iam role 
resource "aws_iam_role_policy_attachment" "ecs_task_execution_role"{
  role = aws_iam_role.ecs_task_execution_role.name
  policy_arn = aws_iam_policy.ecs_task_execution_policy.arn
}


