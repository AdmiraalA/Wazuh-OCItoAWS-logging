# AWS Provider
provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.aws_region
}

# OCI Provider
provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region           = var.oci_region
}

# Create S3 bucket
resource "aws_s3_bucket" "oci_logs_bucket" {
  bucket = "your-s3-bucket-name"
  acl    = "private"
}

# Create OCI Function
resource "oci_functions_application" "example" {
  display_name = "example"
  compartment_id = var.oci_compartment_id
}

resource "oci_functions_function" "example" {
  application_id = oci_functions_application.example.id
  display_name   = "example-function"
  compartment_id = var.oci_compartment_id
  runtime        = "python3.8"

  source {
    dir      = "${path.module}/function_code"
    includes = ["*"]
  }
}

# Create Service Connector
resource "oci_service_connector_service_connector" "example" {
  compartment_id  = var.oci_compartment_id
  display_name    = "example-service-connector"
  enable_logging  = true
  is_enabled      = true

  source {
    service_type = "LOG"
    stream_id    = "your-oci-log-stream-id"
  }

  target {
    service_type = "FUNCTION"
    function_id  = oci_functions_function.example.id
  }
}
