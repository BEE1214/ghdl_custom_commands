#!/bin/bash
##====================================##
##=- Project: ghdls_custom_commands -=##
##=- Author:           Adam Dvorsky -=##
##=- Date:               2019-11-04 -=##
##====================================##

function syntghdl () {
    if [ -z "$2" ]; then
        ghdl -s $1.vhd
        ghdl -a $1.vhd
    else
        ghdl -s $1.vhd
        ghdl -s $2.vhd
        ghdl -a $1.vhd
        ghdl -a $2.vhd
    fi
}

function runghdl () {
    ghdl -e $1
    ghdl -r $1
}

function graphghdl () {
    ghdl -e $1
    ghdl -r $1 --vcd=$1.vcd
    gtkwave $1.vcd
}