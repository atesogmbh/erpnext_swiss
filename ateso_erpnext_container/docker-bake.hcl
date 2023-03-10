variable "FRAPPE_VERSION" {
  default = "version-13"
}

variable "ERPNEXT_VERSION" {
  default = "version-13"
}

variable "REGISTRY_NAME" {
  default = "ateso"
}

variable "BACKEND_IMAGE_NAME" {
  default = "erpnext-worker"
}

variable "FRONTEND_IMAGE_NAME" {
  default = "erpnext-nginx"
}

variable "VERSION" {
  default = "13.0.1"
}

group "default" {
    targets = ["backend", "frontend"]
}

target "backend" {
    dockerfile = "images/backend.Dockerfile"
    tags = ["${REGISTRY_NAME}/${BACKEND_IMAGE_NAME}:${VERSION}"]
    args = {
      "ERPNEXT_VERSION" = ERPNEXT_VERSION
    }
}

target "frontend" {
    dockerfile = "images/frontend.Dockerfile"
    tags = ["${REGISTRY_NAME}/${FRONTEND_IMAGE_NAME}:${VERSION}"]
    args = {
      "FRAPPE_VERSION" = FRAPPE_VERSION
      "ERPNEXT_VERSION" = ERPNEXT_VERSION
    }
}
