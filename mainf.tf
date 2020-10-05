resource "google_compute_shared_vpc_host_project" "host-shared-vpc" {
  project = var.host_project_name
}

resource "google_compute_shared_vpc_service_project" "service" {
  count           = length(var.service_projects)
  host_project    = var.host_project_name
  service_project = element(keys(var.service_projects), count.index)

  // Shared VPC needs to be enabled on host project fist
  depends_on = [google_compute_shared_vpc_host_project.host-shared-vpc]
}

resource "google_compute_subnetwork_iam_member" "cloudservices" {
  count      = length(var.service_projects)
  subnetwork = var.service_networks[element(keys(var.service_networks), count.index)]
  role       = "roles/compute.networkUser"
  member     = "serviceAccount:${var.service_projects[element(keys(var.service_projects), count.index)]}@cloudservices.gserviceaccount.com"
}
