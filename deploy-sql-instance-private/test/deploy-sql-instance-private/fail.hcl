

mock "tfplan/v2" {
  module {
    source = "mock-tfplanv2-fail.sentinel"
  }
}

test {
  rules = {
    main = false
  }
}
