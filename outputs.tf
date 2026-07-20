output "vpc_id"{
    value = aws_vpc.vpc.id
}

output "public_subnet_az1_id"{
    value = aws_subnet.public_subnet_az1.id
}

output "s3_bucket_id"{
    value = aws_s3_bucket.env_file_bucket.id
}

output "ecs_cluster_id"{
    value = aws_ecs_cluster.ecs_cluster.id
}


