resource "google_cloudfunctions_function" "hello_world" {
  name        = "hello-world-function"
  description = "Hello World Function"
  runtime     = "python39"
  region      = "us-central1"

  entry_point = "hello_world"

  source_archive_bucket = google_storage_bucket.source_bucket.name
  source_archive_object = google_storage_bucket_object.function_zip.name

  https_trigger = {}

  memory = "256MB"
}

resource "google_storage_bucket" "source_bucket" {
  name     = "hello-world-source-bucket"
  location = "US"
}

resource "google_storage_bucket_object" "function_zip" {
  name   = "function.zip"
  bucket = google_storage_bucket.source_bucket.name
  source = "./cloud_function.zip"  # Ensure the zip file is created
}
