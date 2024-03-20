variable "VERSION" {
    default = "0.124.1"
}

target "default" {
    name = join("", ["hugo-${base}", equal(extended, true) ? "-extended" : ""])
    matrix = {
        extended = [true, false]
        base = ["debian", "ubuntu"]
    }
    target = "${base}"
    args = {
        VERSION = "${VERSION}"
        EXTENDED = equal(extended, true) ? "_extended" : ""
    }
    platforms = ["linux/amd64", "linux/arm64"]
    tags = [
        "ghcr.io/tbaile/hugo:${VERSION}-${base}${equal(extended, true) ? "-extended" : ""}",
        equal(extended, true) && equal(base, "debian") ? "ghcr.io/tbaile/hugo:latest" : ""
    ]
}
