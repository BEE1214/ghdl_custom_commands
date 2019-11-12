#!/bin/bash
##====================================##
##=- Project: ghdls_custom_commands -=##
##=- Author:           Adam Dvorsky -=##
##=- Date:               2019-11-04 -=##
##====================================##

# VHDL syntesis with two possible files.
function runghdl () {
    if [[ $# -gt 3 ]]; then
        echo "Too many arguments..."
        echo "Exiting..."
        return
    fi

    iMODULE=$2
    iTESTBENCH=$3
    if [ ! -f "$iMODULE.vhd" ] && [ $1 != "-h" ]; then
        echo "File $iMODULE doesn't exist..."
        echo "Exiting..."
        return 1
    fi

    if [ $# -eq 3 ] && [ ! -f "$iTESTBENCH.vhd"]; then 
        echo "File $iTESTBENCH doesn't exist"
        echo "Exiting..."
        return
    fi
#============================================================================================# 
#============================== Case for diferent commands ==================================#
#============================================================================================# 
    case "$1" in
        -s) 
            if [ -z "$iTESTBENCH" ]; then
                echo "Syntesysing $iMODULE"
                ghdl -s $iMODULE.vhd
            else
                echo "Syntesysing $iMODULE"
                ghdl -s $iMODULE.vhd
                echo "Syntesysing $iTESTBENCH"
                ghdl -s $iTESTBENCH.vhd
            fi
        ;;
        -a) 
            if [ -z "$iTESTBENCH" ]; then
                echo "Syntesysing $iMODULE"
                ghdl -s $iMODULE.vhd
                echo "Analysing $iMODULE"
                ghdl -a $iMODULE.vhd
            else
                echo "Syntesysing $iMODULE"
                ghdl -s $iMODULE.vhd
                echo "Syntesysing $iTESTBENCH"
                ghdl -s $iTESTBENCH.vhd
                echo "Syntesysing $iMODULE"
                ghdl -a $iMODULE.vhd
                echo "Syntesysing $TESTBENCH"
                ghdl -a $iTESTBENCH.vhd
            fi
        ;;
        -r) 
            echo "Syntesysing $iMODULE"
            ghdl -s $iMODULE.vhd
            echo "Syntesysing $iTESTBENCH"
            ghdl -s $iTESTBENCH.vhd
            echo "Syntesysing $iMODULE"
            ghdl -a $iMODULE.vhd
            echo "Syntesysing $TESTBENCH"
            ghdl -a $iTESTBENCH.vhd
            echo "Elaborating $iTESTBENCH"
            ghdl -e $iTESTBENCH
            echo "Running $iTETSBENCH"
            ghdl -r $iTESTBENCH --vcd=$iTESTBENCH.vcd
            echo "Openning gtkwave"
            gtkwave $iTESTBENCH.vcd
        ;;

        -h) if [ -z "$iMODULE" ] && [ -z "$iTESTBENCH" ]; then
                echo "runghdl -s     syntesis - optional two files"
                echo "runghdl -a     syntesis and analysis"
                echo "runghdl -r     running code after syntesis with graphical output file"
                echo "runghdl -h     show this help"
            else
                echo "Wrong arguments"
                echo "Exiting..."
                return
            fi
        ;;
        *)  echo "Wrong argument"
            echo "Exiting..."
            return
        ;;
    esac
#============================================================================================#    
#==================================== End of Commands =======================================#
#============================================================================================#    
}