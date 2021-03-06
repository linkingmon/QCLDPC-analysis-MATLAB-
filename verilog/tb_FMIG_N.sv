`include "FMIG2.sv"
module tb_FMIG2;
parameter BITS = 5 + 3;
parameter INPUTS = 255;
parameter INPUTS_BITS = $clog2(INPUTS);

logic signed [BITS-1:0] x [INPUTS-1:0];
logic signed [BITS-1:0] min;
logic [INPUTS_BITS-1:0] idx;

integer min_real, idx_real;
integer IN[INPUTS-1:0];
integer f, i;
integer cnt;

FMIG_N #(.BITS(BITS), .N(INPUTS)) FMIG_N_0(
    .x(x),
    .out(min),
    .idx(idx)
);

initial begin

f = $fopen("./FMIG2k/FMIG255.txt", "r");
$fsdbDumpfile("FMIG2_N.fsdb");
$fsdbDumpvars();
while (!$feof(f)) begin
    for(cnt = INPUTS - 1 ; cnt >= 0 ; cnt = cnt - 1) begin
        $fscanf(f, "%d", IN[cnt]);
        x[cnt] = IN[cnt];
    end
    $fscanf(f, "%d %d\n", min_real, idx_real);
    #10;
    $display("%d %d %d %d\n", min, idx, min_real, idx_real);
    if(min_real != min || idx_real != idx) begin
        $display("############################");
        $display("###    Fail TestBench    ###");
        $display("############################");
        $finish;
    end
end
$display("############################");
$display("###    Pass TestBench    ###");
$display("############################");
end
endmodule
