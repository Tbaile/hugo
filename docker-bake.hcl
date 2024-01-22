variable "VERSION" {
    default = "0.121.2"
}

target "default" {
    name = join("", ["hugo-${base}", equal(extended, true) ? "-extended" : ""])
    matrix = {
        version = ["0.121.2", "0.119.0"]
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