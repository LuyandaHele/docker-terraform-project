# creating a ecs cluster
resource "aws_ecs_cluster" "ecs_cluster"{
    name = "${var.project_name}-${var.environment}-ecs-cluster"

    setting {
        name  = "containerInsights"
        value = "disabled"
    }
}

# creating cloudwatch log group
resource "aws_cloudwatch_log_group" "log_group"{
    name = "/ecs/${var.project_name}-${var.environment}-td"

    lifecycle {
      create_before_destroy = true
    }
}

#creating container definitions
#creating container definitions
resource "aws_ecs_task_definition" "app_task" {
  family                   = "${var.project_name}-${var.environment}-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture         = var.architecture
  }

  container_definitions = jsonencode([
    {
      name      = "${var.project_name}-${var.environment}-container"
      image     = "${var.container_image}"
      essential = true

      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]

      # environmentFiles block removed temporarily — not needed for the nginx test image

      logConfiguration = {
        logDriver = "awslogs",
        options = {
          "awslogs-group"         = "${aws_cloudwatch_log_group.log_group.name}",
          "awslogs-region"        = "${var.region}",
          "awslogs-stream-prefix" = "ecs"
        }
      }
    }
  ])
}

# creating ecs service 

resource "aws_ecs_service" "ecs_service"{
    name = "${var.project_name}-${var.environment}-ecs-service"
    launch_type = "FARGATE"
    cluster = aws_ecs_cluster.ecs_cluster.id
    task_definition = aws_ecs_task_definition.app_task.id
    platform_version = "LATEST"
    desired_count = 2
    deployment_minimum_healthy_percent = 100
    deployment_maximum_percent = 200

    enable_ecs_managed_tags = false
    propagate_tags = "SERVICE"

    network_configuration {
        subnets = [aws_subnet.private_app_subnet_az1.id, aws_subnet.private_app_subnet_az2.id]
        security_groups = [aws_security_group.app_webserver_security_group.id]
        assign_public_ip = false
    }

    load_balancer {
        target_group_arn = aws_lb_target_group.alb_target_group.arn
        container_name = "${var.project_name}-${var.environment}-container"
        container_port = 80
    }
}




