resource "aws_docdb_cluster" "docdb" {
  cluster_identifier      = "roboshop-${var.ENV}-docdb"
  engine                  = "docdb"
  master_username         = "admin1"
  master_password         = "roboshop1"
  vpc_security_group_ids  = [aws_security_group.allow_mongodb.id]
  db_subnet_group_name    = aws_docdb_subnet_group.docdb.id
#   backup_retention_period = 5
#   preferred_backup_window = "07:00-09:00"
#   skip_final_snapshot     = true
}


resource "aws_docdb_subnet_group" "docdb" {
  name       = "roboshop-${var.ENV}-docdb-subnet-group"
  subnet_ids = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS

  tags = {
    Name = "roboshop-${var.ENV}-docdb-subnet-group"
  }
}


resource "aws_docdb_cluster_instance" "cluster_instances" {
  count              = 1
  identifier         = "roboshop-${var.ENV}-docdb-nodes"
  cluster_identifier = aws_docdb_cluster.docdb.id
  instance_class     = "db.t3.medium"
}

