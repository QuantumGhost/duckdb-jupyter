# docker-bake.hcl

variable TAG {
  default = "latest"
}

variable IMAGE {
  default = "ghcr.io/quantumghost/duckdb-jupyter"
}

variable EXTRA_TAGS {
  default = ""
}

target "default" {
  dockerfile = "Dockerfile"
  tags = concat([for each in split(",", EXTRA_TAGS): "${IMAGE}:${each}" if each != ""], ["${IMAGE}:${TAG}"])
}
