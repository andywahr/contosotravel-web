variable "namePrefix" {
  type = "string"
}

variable "location" {
  type = "string"
}

variable "resourceGroupName" {
  type = "string"
}

variable "webSiteFQDN" {
  type = "string"
}

variable "enabled" {
  type = "string"
}

resource "azurerm_cdn_profile" "cdn" {
  name                = "cdn-${var.namePrefix}"
  location            = "northcentralus"
  resource_group_name = "${var.resourceGroupName}"
  sku                 = "Standard_Microsoft"
  count               = "${var.enabled == "true" ? 1 : 0}"
}

resource "azurerm_cdn_endpoint" "cdnEndpoint" {
  name                = "cdn-contosotravel-${lower(var.namePrefix)}"
  profile_name        = "${azurerm_cdn_profile.cdn.name}"
  location            = "northcentralus"
  resource_group_name = "${var.resourceGroupName}"
  count               = "${var.enabled == "true" ? 1 : 0}"
  optimization_type   = "GeneralWebDelivery"
  origin_host_header  = "${var.webSiteFQDN}"

  origin {
    name      = "contosoTravel"
    host_name = "${var.webSiteFQDN}"
  }
}

output "webSiteFQDN" {
  value = "${element(concat(azurerm_cdn_endpoint.cdnEndpoint.*.name, list("")), 0)}.azureedge.net"
}
