resource "aws_vpc" "default" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true

    tags = {
        Name = "terraform-aws-vpc"
    }
}

resource "aws_internet_gateway" "default" {
    vpc_id = "${aws_vpc.default.id}"
}


/*
  Public Subnet
*/
resource "aws_subnet" "eu-west-1a-public" {
    vpc_id = "${aws_vpc.default.id}"

    cidr_block = "${var.public_subnet_cidr_1a}"
    availability_zone = "eu-west-1a"

    tags = {
        Name = "Public Subnet"
    }
}

resource "aws_route_table" "eu-west-1a-public" {
    vpc_id = "${aws_vpc.default.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.default.id}"
    }

    tags = {
        Name = "Public Subnet"
    }
}

resource "aws_subnet" "eu-west-1b-public" {
    vpc_id = "${aws_vpc.default.id}"

    cidr_block = "${var.public_subnet_cidr_1b}"
    availability_zone = "eu-west-1b"

    tags = {
        Name = "Public Subnet"
    }
}

resource "aws_route_table" "eu-west-1b-public" {
    vpc_id = "${aws_vpc.default.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.default.id}"
    }

    tags = {
        Name = "Public Subnet"
    }
}

resource "aws_route_table_association" "eu-west-1a-public" {
    subnet_id = "${aws_subnet.eu-west-1a-public.id}"
    route_table_id = "${aws_route_table.eu-west-1a-public.id}"
}

resource "aws_route_table_association" "eu-west-1b-public" {
    subnet_id = "${aws_subnet.eu-west-1b-public.id}"
    route_table_id = "${aws_route_table.eu-west-1b-public.id}"
}

/*
  Private Subnet
*/
resource "aws_subnet" "eu-west-1a-private" {
    vpc_id = "${aws_vpc.default.id}"

    cidr_block = "${var.private_subnet_cidr_1a}"
    availability_zone = "eu-west-1a"

    tags = {
        Name = "Private Subnet"
    }
}

resource "aws_route_table" "eu-west-1a-private" {
    vpc_id = "${aws_vpc.default.id}"

    route {
        cidr_block = "0.0.0.0/0"
    }

    tags = {
        Name = "Private Subnet"
    }
}


resource "aws_subnet" "eu-west-1b-private" {
    vpc_id = "${aws_vpc.default.id}"

    cidr_block = "${var.private_subnet_cidr_1b}"
    availability_zone = "eu-west-1a"

    tags = {
        Name = "Private Subnet"
    }
}

resource "aws_route_table" "eu-west-1b-private" {
    vpc_id = "${aws_vpc.default.id}"

    route {
        cidr_block = "0.0.0.0/0"
    }

    tags = {
        Name = "Private Subnet"
    }
}

resource "aws_route_table_association" "eu-west-1a-private" {
    subnet_id = "${aws_subnet.eu-west-1a-private.id}"
    route_table_id = "${aws_route_table.eu-west-1a-private.id}"
}

resource "aws_route_table_association" "eu-west-1b-private" {
    subnet_id = "${aws_subnet.eu-west-1b-private.id}"
    route_table_id = "${aws_route_table.eu-west-1b-private.id}"
}