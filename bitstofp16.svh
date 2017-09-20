function automatic shortreal bitstofp16(input [15:0] bits);
    //	refer to ftp://ftp.fox-toolkit.org/pub/fasthalffloatconversion.pdf
	
	bit       s = bits[15];
    bit [4:0] e = bits[14:10];
    bit [9:0] m = bits[9:0];

    localparam  shortreal mw_9 = 1.0 / 2;
    localparam  shortreal mw_8 = 1.0 / 4;
    localparam  shortreal mw_7 = 1.0 / 8;
    localparam  shortreal mw_6 = 1.0 / 16;
    localparam  shortreal mw_5 = 1.0 / 32;
    localparam  shortreal mw_4 = 1.0 / 64;
    localparam  shortreal mw_3 = 1.0 / 128;
    localparam  shortreal mw_2 = 1.0 / 256;
    localparam  shortreal mw_1 = 1.0 / 512;
    localparam  shortreal mw_0 = 1.0 / 1024;

    if(e >= 5'd1 && e <= 5'd30)
        bitstofp16 =  ((2.0)** signed'(e-15)) * (1.0 + mw_0*m[0] + mw_1*m[1] + mw_2*m[2] 
                + mw_3*m[3] + mw_4*m[4] + mw_5*m[5] + mw_6*m[6] + mw_7*m[7] + mw_8*m[8] + mw_9*m[9]);  
    
    else if(e == 5'd0 && m != 10'd0)
        bitstofp16 = ((2.0)**(-14)) * (mw_0*m[0] + mw_1*m[1] + mw_2*m[2] 
                + mw_3*m[3] + mw_4*m[4] + mw_5*m[5] + mw_6*m[6] + mw_7*m[7] + mw_8*m[8] + mw_9*m[9]);   

    else if(e == 5'd0 && m == 10'd0)
        bitstofp16 = 0.0;

    else if(e == 5'd31 && m == 10'd0)
        bitstofp16 = $bitstoshortreal(32'b0_11111111_00000000000000000000000);

    else if(e == 5'd31 && m != 10'd0)
        bitstofp16 = $bitstoshortreal(32'b0_11111111_00000000000000000000001);

 
    if(s) 
        bitstofp16 = (-1.0) * bitstofp16;
    


endfunction : bitstofp16