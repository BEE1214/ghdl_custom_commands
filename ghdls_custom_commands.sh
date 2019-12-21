#!/bin/bash
##====================================##
##=- Project: ghdls_custom_commands -=##
##=- Author:           Adam Dvorsky -=##
##=- Date:               2019-11-04 -=##
##====================================##

# VHDL syntesis with two possible files.
function runghdl () {
    if [[ $# -gt 4 ]]; then
        echo "Too many arguments..."
        echo "Exiting..."
        return
    fi

    iMODULE=$2
    iTESTBENCH=$3
    iSTOPTIME=$4
    # if [ ! -f "$iMODULE.vhd" ] && [ $1 != "-h" ]; then
    #     echo "File $iMODULE doesn't exist..."
    #     echo "Exiting..."
    #     return 1
    # fi

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
                echo "Syntesysing $iMODULE.vhd..."
                ghdl -s $iMODULE.vhd
                echo "Done..."
            else
                echo "Syntesysing $iMODULE.vhd..."
                ghdl -s $iMODULE.vhd
                echo "Syntesysing $iTESTBENCH.vhd..."
                ghdl -s $iTESTBENCH.vhd
                echo "Done..."
            fi
        ;;
        -a) 
            if [ -z "$iTESTBENCH" ]; then
                echo "Syntesysing $iMODULE.vhd..."
                ghdl -s $iMODULE.vhd
                echo "Analysing $iMODULE.vhd..."
                # ghdl -a -Wa,--32 $iMODULE.vhd
                ghdl -a $iMODULE.vhd
            else
                echo "Syntesysing $iMODULE.vhd..."
                ghdl -s $iMODULE.vhd
                echo "Analyzing $iMODULE.vhd..."
                ghdl -a $iMODULE.vhd
                echo "Syntesysing $iTESTBENCH.vhd..."
                ghdl -s $iTESTBENCH.vhd
                # ghdl -a -Wa,--32 $iMODULE.vhd
                echo "Analyzing $TESTBENCH.vhd..."
                ghdl -a $iTESTBENCH.vhd
                # ghdl -a -Wa,--32 $iTESTBENCH.vhd
            fi
        ;;
        -r) 
            echo "Syntesysing $iMODULE.vhd..."
            ghdl -s $iMODULE.vhd
            echo "Analyzing $iMODULE.vhd..."
            ghdl -a $iMODULE.vhd
            echo "Syntesysing $iTESTBENCH.vhd..."
            ghdl -s $iTESTBENCH.vhd
            # ghdl -a -Wa,--32 $iMODULE.vhd
            echo "Analyzing $iTESTBENCH.vhd..."
            ghdl -a $iTESTBENCH.vhd
            # ghdl -a -Wa,--32 $iTESTBENCH.vhd
            echo "Elaborating $iTESTBENCH.vhd..."
            ghdl -e $iTESTBENCH
            echo "Running $iTESTBENCH.vhd..."
            if [ -z "$iSTOPTIME" ]; then
                ghdl -r $iTESTBENCH --vcd=$iTESTBENCH.vcd
            else
                ghdl -r $iTESTBENCH --vcd=$iTESTBENCH.vcd --stop-time=$iSTOPTIME
            fi                
            # ghdl -r $iTESTBENCH --stop-time=200ns
            echo "Done"
            # echo "Openning gtkwave"
            # gtkwave $iTESTBENCH.vcd
        ;;

        -h) if [ -z "$iMODULE" ] && [ -z "$iTESTBENCH" ]; then
                # echo "runghdl -s     syntesis - optional two files"
                # echo "runghdl -a     syntesis and analysis"
                # echo "runghdl -r     running code after syntesis with graphical output file"
                # echo "runghdl -h     show this help"
                cat runghdl_help.txt
            else
                echo "Wrong arguments"
                echo "Exiting"
                return
            fi
        ;;
        *)  echo "Wrong argument"
            echo "Exiting"
            return
        ;;
    esac
#============================================================================================#    
#==================================== End of Commands =======================================#
#============================================================================================#    
}