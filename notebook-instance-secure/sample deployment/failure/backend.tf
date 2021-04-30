terraform {
  backend "remote" {
    organization = "VishnuKvs"

    workspaces {
      name = "MyWorkspace"
    }
  }
}