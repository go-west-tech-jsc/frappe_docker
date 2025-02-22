target "erpnext" {
    inherits = ["default-args"]
    context = "."
    dockerfile = "images/custom/Containerfile"
    target = "backend"
    tags = tag("erpnext", "${ERPNEXT_VERSION}")
}

target "base" {
    inherits = ["default-args"]
    context = "."
    dockerfile = "images/custom/Containerfile"
    target = "base"
    tags = tag("base", "${FRAPPE_VERSION}")
}

target "build" {
    inherits = ["default-args"]
    context = "."
    dockerfile = "images/custom/Containerfile"
    target = "builder"
    tags = tag("build", "${ERPNEXT_VERSION}")
}