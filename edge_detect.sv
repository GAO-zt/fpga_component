module edge_detect (
    input  logic clk,
    input  logic signal_i,
    output logic signal_i_posedge,
    output logic signal_i_negedge
);

logic   signal_i_delay;
always_ff @(posedge clk) 
    signal_i_delay <= signal_i;

assign  signal_i_posedge = (signal_i && ~signal_i_delay);
assign  signal_i_negedge = (~signal_i && signal_i_delay);

endmodule