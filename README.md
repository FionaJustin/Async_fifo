#Asynchronous  FIFO design

This fifo is designed for the ratematching of nputs from  two different clocks. The Fifo depth and width has to be passed as parameters into the module to invoke them for your respective usecase.

##Calculations required
FIFO_DEPTH
FIFO_WIDTH

##Data required

1.write_frequency

2.read_frequency

3.No of worstcase continuous writes

##Synchronizers required

1. Data synchronizer
2. Binary to gray converter
