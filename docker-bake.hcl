variable "HUGO_EXTENDED" {
    default = false
}

variable "HUGO_VERSION" {
    default = "0.119.0"
}

variable "BASE_IMAGE" { }

variable "BASE_TAG" { }

target "default" {
    args = {
        HUGO_EXTENDED = equal(true, HUGO_EXTENDED) ? "extended_": "",
        HUGO_VERSION = "${HUGO_VERSION}"
        BASE_IMAGE = "${BASE_IMAGE}"
        BASE_TAG = "latest"
    }
    tags = [
        "hugo:${BASE_IMAGE}-${BASE_TAG}-${HUGO_VERSION}"
    ]
    platforms = ["linux/amd64", "linux/arm64"]
}


target "local-build" {
    inherits = ["default"]
    platforms = ["linux/amd64"]
    output = ["type=docker"]
}