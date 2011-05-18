#Clock
create_clock [get_ports {MCI} ] -name {MCI} -period 13 
create_clock [get_ports {nRD} ] -name {nRD} -period 100 
create_clock [get_ports {SCK} ] -name {SCK} -period 100 
create_clock [get_ports {SDA} ] -name {SDA} -period 100 
#Generated Clock
#Input Delay
#Output Delay
#Max-delay
#False Path
#Multi-cycle
