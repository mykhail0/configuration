#!/bin/awk
$1 == "gtk-application-prefer-dark-theme" {$3 = "true"}
1
