resource "aws_db_subnet_group" "bedrock" {
  name       = "bedrock-db-subnets"
  subnet_ids = var.private_subnet_ids

  tags = {
    Project = "tinyuka-2025-capstone"
  }
}

resource "aws_security_group" "rds" {
  name        = "bedrock-rds-sg"
  description = "Allow DB traffic only from EKS nodes"
  vpc_id      = var.vpc_id

  ingress {
    description     = "MySQL from EKS nodes"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [var.node_security_group_id]
  }

  ingress {
    description     = "PostgreSQL from EKS nodes"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [var.node_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Project = "tinyuka-2025-capstone"
  }
}

resource "aws_db_instance" "catalog_mysql" {
  identifier                  = "bedrock-catalog-mysql"
  engine                      = "mysql"
  engine_version              = "8.0"
  instance_class              = "db.t3.micro"
  allocated_storage           = 20
  db_subnet_group_name        = aws_db_subnet_group.bedrock.name
  vpc_security_group_ids      = [aws_security_group.rds.id]
  username                    = "catalog_admin"
  manage_master_user_password = true
  backup_retention_period     = 1
  skip_final_snapshot         = true
  publicly_accessible         = false

  tags = {
    Project = "tinyuka-2025-capstone"
  }
}

resource "aws_db_instance" "orders_postgres" {
  identifier                  = "bedrock-orders-postgres"
  engine                      = "postgres"
  engine_version              = "16"
  instance_class              = "db.t3.micro"
  allocated_storage           = 20
  db_subnet_group_name        = aws_db_subnet_group.bedrock.name
  vpc_security_group_ids      = [aws_security_group.rds.id]
  username                    = "orders_admin"
  manage_master_user_password = true
  backup_retention_period     = 1
  skip_final_snapshot         = true
  publicly_accessible         = false

  tags = {
    Project = "tinyuka-2025-capstone"
  }
}

resource "aws_dynamodb_table" "carts" {
  name         = "bedrock-carts"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = {
    Project = "tinyuka-2025-capstone"
  }
}
