# CollectorCC

## Environment
* The *libmnl* should be installed.
  - i.e.) sudo apt-get install libmnl0 libmnl-dev
* Linux kernel 4.14
* TCP ARC is already installed.

## Build
* make
* If the kernel header files are correctly installed `(sock_diag.h, inet_diag.h)`,
 `-D_CUSTOM_DIAG_HEADER__` in the Makefile can be removed.

## Usage
* -l: With this option, the program would print one json object per line.
      Without this option (default), the program would print one json per
      line, but each of these objects are in one big json array. So when the
      program is stopped (i.e. User type in Ctrl-C), the program would print
      "]" at the end. This is added by the signal handler.
* -w: With this option, the program would write output to the designated
      file. The path to the file should be passed with this option.
* -h: Prints usage of the program

### Examples
    ./collectorCC
    ./collectorCC -l
    ./collectorCC -w output.txt
    ./collectorCC -h

## Useful commit messages
    commit f59f9e4cd6b744eb02540c54ca29dea8be6819a0
    Author: Beomjun Kim <beomjun.kim@verizon.com>
    Date:   Fri May 11 15:25:51 2018 -0400
    
        Fix bug that TCP info of flow with IPv6 address | Modify indentations
        
        * `SKNLGRP_INET_TCP_DESTROY` was not the value of the event to subscribe.
        * It was the location of the set bit in an unsigned int variable.
        * So the program supports IPv6 address after I added the set bit on the
          (SKNLGRP_INET6_TCP_DESTROY)th position on the unsigned int varaible.
        * The program closes the netlink socket that is bound in this program
          at the end of the execution "and" when the program receives SIGINT
          (Ctrl+c). If the netlink socket is not closed completely, it might
          set the process to the D state at the next time of the execution.
        * I changed the indentation of the code from tab to 4 spaces.
    
    commit 4ff1c70fc26e2bcbd7a0f7f7c012b52f99925214
    Author: Beomjun Kim <beomjun.kim@verizon.com>
    Date:   Mon May 7 11:44:41 2018 -0400
    
        Add more variables in tcp_info when printing tcp_info
        
        * Add almost every variables in `tcp_info` when printing `tcp_info`
        * Modify the code to print `"cong_control":{"arc":{ ARC_INFORMATION }}`.
        Previously, the format was `"cong_control":{ ARC_INFORMATION }`
        * Modify the logic for printing `"congalg"` and `"cong_control"` values. Now they
        are printed when `tcp_info` structure is passed from kernel.
