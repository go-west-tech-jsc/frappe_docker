variable "APPS_JSON_BASE64" {
    default = ""
}

target "default-args" {
    args = {
        FRAPPE_PATH = "${FRAPPE_REPO}"
        ERPNEXT_PATH = "${ERPNEXT_REPO}"
        BENCH_REPO = "${BENCH_REPO}"
        FRAPPE_BRANCH = "${FRAPPE_VERSION}"
        ERPNEXT_BRANCH = "${ERPNEXT_VERSION}"
        PYTHON_VERSION = "${PYTHON_VERSION}"
        NODE_VERSION = "${NODE_VERSION}"
        APPS_JSON_BASE64 = "${APPS_JSON_BASE64}"
    }
}

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