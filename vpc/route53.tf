resource "aws_route53_zone" "interqonecta" {
  name = "interqonecta.run"
}

resource "aws_route53_record" "server1-record" {
  name    = "server1.interqonecta.run"
  type    = "A"
  ttl     = "300"
  zone_id = aws_route53_zone.interqonecta.zone_id
  records = ["104.236.247.8"]
}

resource "aws_route53_record" "www-record" {
  name    = "www.interqonecta.run"
  type    = "A"
  ttl     = "300"
  zone_id = aws_route53_zone.interqonecta.zone_id
  records = ["104.236.247.8"]
}

resource "aws_route53_record" "mail1-record" {
  name    = "interqonecta.run"
  type    = "MX"
  zone_id = aws_route53_zone.interqonecta.zone_id
  ttl     = "300"
  records = ["1 aspmx.l.google.com"]
}

output "ns-servers" {
  value = aws_route53_zone.interqonecta.name_servers
}