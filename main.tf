terraform {
  cloud {
    organization = var.tfc_organization
    workspaces {
      tags = [var.tfc_workspace_tag]
    }
  }

  required_providers {
    tfe = {
      version = "~> 0.31.0"
    }
    consul = {
      version = "~> 2.15.1"
    }
  }
}

data "tfe_outputs" "workspace" {
  organization = var.tfc_organization
  workspace = var.tfc_workspace
}


provider "consul" {
  address    = data.tfe_outputs.workspace.values.consul_server_endpoint
  datacenter = "dc1"
  token = var.consul_token
}