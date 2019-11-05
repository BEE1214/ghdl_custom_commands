#!/bin/bash
##====================================##
##=- Project: ghdls_custom_commands -=##
##=- Author:           Adam Dvorsky -=##
##=- Date:               2019-11-04 -=##
##====================================##

# VHDL syntesis with two possible files.
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

# Run VHDL code.
function runghdl () {
    ghdl -e $1
    ghdl -r $1
}

# Run VHDL code with graph exit.
function graphghdl () {
    ghdl -e $1
    ghdl -r $1 --vcd=$1.vcd
    gtkwave $1.vcd
}

# Function for full VHDL synthesis and run code.
# If two argumenst entered, first argument have to be testbench.
function runsyntghdl () {
    if [ -z "$2" ]; then
        ghdl -s $1.vhd
        ghdl -a $1.vhd
        ghdl -e $1
        ghdl -r $1
    else
        ghdl -s $1.vhd
        ghdl -s $2.vhd
        ghdl -a $1.vhd
        ghdl -a $2.vhd
        ghdl -e $1
        ghdl -r $1 --vcd=$1.vcd
        # gtkwave $1.vcd
    fi

    if [ -f "$1.vcd" ]; then
        gtkwave $1.vcd
    fi
}