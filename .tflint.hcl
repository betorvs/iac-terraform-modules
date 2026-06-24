config {
  module = true
  force = false
}

# Enables default, recommended rules for Terraform syntax and clean patterns
plugin "terraform" {
  enabled = true
  preset  = "recommended"
}
