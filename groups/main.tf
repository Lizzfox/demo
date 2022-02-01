# Copyright 2021 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

terraform {
  required_version = ">=0.14"
  required_providers {
    google      = "~> 3.0"
    google-beta = "~> 3.0"
    kubernetes  = "~> 1.0"
  }
  backend "gcs" {
    bucket = "terraform-state-33890"
    prefix = "groups"
  }
}


module "project" {
  source  = "terraform-google-modules/project-factory/google//modules/project_services"
  version = "~> 11.2.0"

  project_id    = "devops-project-338901"
  activate_apis = []
}
# Required when using end-user ADCs (Application Default Credentials) to manage Cloud Identity groups and memberships.
provider "google-beta" {
  user_project_override = true
  billing_project       = module.project.project_id
}


module "group_auditors_yahorg_com" {
  source  = "terraform-google-modules/group/google"
  version = "~> 0.3"

  id           = "group-auditors@yahorg.com"
  customer_id  = "C02m6kde5"
  display_name = "group-auditors"
  owners       = ["yahorg.admin@yahorg.com"]
}

module "group_cicd_viewers_yahorg_com" {
  source  = "terraform-google-modules/group/google"
  version = "~> 0.3"

  id           = "group-cicd-viewers@yahorg.com"
  customer_id  = "C02m6kde5"
  display_name = "group-cicd-viewers"
}

module "group_cicd_editors_yahorg_com" {
  source  = "terraform-google-modules/group/google"
  version = "~> 0.3"

  id           = "group-cicd-editors@yahorg.com"
  customer_id  = "C02m6kde5"
  display_name = "group-cicd-editors"
}
