resource "null_resource" "schema" {

    # This make sures that this null_resource will only be executed post the creation of the RDS only    
    depends_on = [aws_db_instance.mysql]

      provisioner "local-exec" {
        command = <<EOF
            cd /tmp
            curl -s -L -o /tmp/mysql.zip "https://github.com/stans-robot-project/mysql/archive/main.zip"
            unzip -o mysql.zip
            cd mysql-main
            mysql -h ${aws_db_instance.mysql.address}  -uadmin1 -pRoboShop1 < shipping.sql
        EOF
    }
}


resource "aws_route53_record" "mysql" {
  zone_id = "Z08185973US3IG8LL97B8"
  name    = "mysql-${var.ENV}.roboshop.internal"
  type    = "CNAME"
  ttl     = 10
  records = [aws_db_instance.mysql.address]
}