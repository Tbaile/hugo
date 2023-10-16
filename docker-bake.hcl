variable "VERSION" {
    default = "0.119.0"
}

variable "EXTENDED" {
    default = false
} 

variable "TARGET" { }

target "build" {
    args = {
        VERSION = VERSION
        EXTENDED = equal(EXTENDED, true) ? "_extended" : ""
    }
}
