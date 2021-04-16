
mock "tfplan/v2" {
  module {
    source = "mock-tfplanv2-pass.sentinel"
  }
}

test {
  rules = {
    main = true
  }
}
