#!/bin/awk
$1 == "gtk-application-prefer-dark-theme" {$3 = "false"}
1
