resource "consul_config_entry" "service_splitter_fruits" {
  kind = "service-splitter"
  name = "${data.tfe_outputs.workspace.values.project_tag}-fruits"

  config_json = jsonencode({
    Splits = [
      {
        Weight = 90
      },
      {
        Weight = 10
        Service = "${data.tfe_outputs.workspace.values.project_tag}-fruits-v2"
      }
    ]
  })
}

resource "consul_config_entry" "service_intentions" {
  kind = "service-intentions"
  name = "${data.tfe_outputs.workspace.values.project_tag}-fruits-v2"

  config_json = jsonencode({
    Sources = [
      {
        Action     = "allow"
        Name       = "${data.tfe_outputs.workspace.values.project_tag}-client"
      }
    ]
  })
}