`timescale 1ns / 1ps

module tb_sha3_256_top;

    reg clk;
    reg rst;

    reg [63:0] data_in;
    reg start;
    reg valid_in;
    reg is_last;
    reg [3:0] valid_bytes;

    wire [255:0] hash_out;
    wire ready;
    wire valid_out;

    integer cycle_cnt;
    integer start_cycle;
    integer done_cycle;
    integer timeout;
    integer stall_count;
    integer pass_count;

    reg [255:0] expected_hash;

    initial begin
        clk = 1'b0;
    end

    always #2.5 clk = ~clk;

    always @(posedge clk) begin
        cycle_cnt = cycle_cnt + 1;
    end

    sha3_256_top uut (
        .clk(clk),
        .rst(rst),
        .data_in(data_in),
        .start(start),
        .valid_in(valid_in),
        .is_last(is_last),
        .valid_bytes(valid_bytes),
        .hash_out(hash_out),
        .ready(ready),
        .valid_out(valid_out)
    );

    task wait_ready;
        integer w;
        begin
            w = 0;

            while ((ready !== 1'b1) && (w < 5000)) begin
                stall_count = stall_count + 1;
                w = w + 1;
                @(negedge clk);
            end

            if (ready !== 1'b1) begin
                $display("[ERROR] ready khong len.");
                $display("cycle     = %0d", cycle_cnt);
                $display("ready     = %b", ready);
                $display("valid_out = %b", valid_out);
                $finish;
            end
        end
    endtask

    task send_word;
        input [63:0] word_data;
        input        last_flag;
        input [3:0]  nbytes;
        begin
            wait_ready();

            data_in     = word_data;
            valid_in    = 1'b1;
            is_last     = last_flag;
            valid_bytes = nbytes;

            @(negedge clk);

            data_in     = 64'd0;
            valid_in    = 1'b0;
            is_last     = 1'b0;
            valid_bytes = 4'd0;
        end
    endtask

    task pulse_start;
        begin
            @(negedge clk);
            start_cycle = cycle_cnt;
            start = 1'b1;

            @(negedge clk);
            start = 1'b0;
        end
    endtask

    task wait_done_and_check;
        input [255:0] expected;
        begin
            timeout = 0;

            while ((valid_out !== 1'b1) && (timeout < 20000)) begin
                @(posedge clk);
                timeout = timeout + 1;
            end

            if (timeout >= 20000) begin
                $display("[ERROR] Timeout waiting valid_out.");
                $display("hash_out = %h", hash_out);
                $finish;
            end

            done_cycle = cycle_cnt;

            $display("Done cycle   = %0d", done_cycle);
            $display("Total cycles = %0d", done_cycle - start_cycle);
            $display("Hash actual   = %h", hash_out);
            $display("Hash expected = %h", expected);

            if (hash_out === expected) begin
                $display("[PASS]");
                pass_count = pass_count + 1;
            end
            else begin
                $display("[FAIL]");
            end

            $display("-----------------------------------------------------");

            repeat (5) @(posedge clk);
        end
    endtask

    task test_case_1_partial_last_word;
        begin
            $display("=====================================================");
            $display("CASE 1: last word chua du 8 byte");
            $display("Message: le van loi 24520990");
            $display("Padding: 0x06 nam trong word cuoi, 0x80 nam o lane 16");
            $display("=====================================================");

            expected_hash =
                256'hb2aa0984f91a46febd75df62559f0a047323b731873000b5ea7e298feeeba72d;

            pulse_start();

            send_word(64'h6c206e617620656c, 1'b0, 4'd8); // "le van l"
            send_word(64'h303235343220696f, 1'b0, 4'd8); // "oi 24520"
            send_word(64'h303939,           1'b1, 4'd3); // "990"

            wait_done_and_check(expected_hash);
        end
    endtask

    task test_case_2_full_last_word_not_lane16;
        begin
            $display("=====================================================");
            $display("CASE 2: last word du 8 byte nhung chua o lane 16");
            $display("Message: 12345678");
            $display("Padding: data o lane 0, 0x06 o lane 1, 0x80 o lane 16");
            $display("=====================================================");

            expected_hash =
                256'h39d1da1f4f9fda75ac2c0b29b76c2149fe57256e3240ce35e1e74d6b6d898222;

            pulse_start();

            send_word(64'h3837363534333231, 1'b1, 4'd8); // "12345678"

            wait_done_and_check(expected_hash);
        end
    endtask

    task test_case_3_full_last_word_at_lane16;
        integer i;
        begin
            $display("=====================================================");
            $display("CASE 3: last word du 8 byte va dung lane 16");
            $display("Message: 136 byte = \"ABCDEFGH\" lap 17 lan");
            $display("Padding: block data day, can them padding block rieng");
            $display("=====================================================");

            expected_hash =
                256'hc71ae79026f31f47e68f42107f64807edcd33956a9eca2f0e8acb63ec0323e2b;

            pulse_start();

            for (i = 0; i < 17; i = i + 1) begin
                if (i == 16)
                    send_word(64'h4847464544434241, 1'b1, 4'd8); // last "ABCDEFGH"
                else
                    send_word(64'h4847464544434241, 1'b0, 4'd8); // "ABCDEFGH"
            end

            wait_done_and_check(expected_hash);
        end
    endtask

    initial begin
        cycle_cnt = 0;
        start_cycle = 0;
        done_cycle = 0;
        timeout = 0;
        stall_count = 0;
        pass_count = 0;

        rst = 1'b1;
        data_in = 64'd0;
        start = 1'b0;
        valid_in = 1'b0;
        is_last = 1'b0;
        valid_bytes = 4'd0;
        expected_hash = 256'd0;

        repeat (10) @(posedge clk);
        rst = 1'b0;
        repeat (5) @(posedge clk);

        $display("=====================================================");
        $display("SHA3-256 PADDING TEST - 3 CASES");
        $display("=====================================================");

        test_case_1_partial_last_word();
        test_case_2_full_last_word_not_lane16();
        test_case_3_full_last_word_at_lane16();

        $display("=====================================================");
        $display("SUMMARY");
        $display("Passed cases = %0d / 3", pass_count);
        $display("Total stall cycles = %0d", stall_count);

        if (pass_count == 3)
            $display("[ALL PASS]");
        else
            $display("[SOME CASES FAILED]");

        $display("=====================================================");

        repeat (10) @(posedge clk);
        $finish;
    end

endmodule