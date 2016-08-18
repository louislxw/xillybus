echo "Test Started"
rm -rf results
mkdir results

#200 iterations: In each iteration 18 different size of blocks are getting processed by HW accelerator 
for len in {1..200}
do
echo "Iteration $len"              
./2in2out_loopback 32 		>>2in2out_lpbk_results_wrwr/result_32.txt
./2in2out_loopback 64 		>>2in2out_lpbk_results_wrwr/result_64.txt
./2in2out_loopback 128 		>>2in2out_lpbk_results_wrwr/result_128.txt
./2in2out_loopback 256 		>>2in2out_lpbk_results_wrwr/result_256.txt
./2in2out_loopback 512 		>>2in2out_lpbk_results_wrwr/result_512.txt
./2in2out_loopback 1024 	>>2in2out_lpbk_results_wrwr/result_1K.txt
./2in2out_loopback 2048 	>>2in2out_lpbk_results_wrwr/result_2K.txt
./2in2out_loopback 4096 	>>2in2out_lpbk_results_wrwr/result_4K.txt
./2in2out_loopback 8192 	>>2in2out_lpbk_results_wrwr/result_8K.txt
./2in2out_loopback 16384 	>>2in2out_lpbk_results_wrwr/result_16K.txt
./2in2out_loopback 32768 	>>2in2out_lpbk_results_wrwr/result_32K.txt
./2in2out_loopback 65536 	>>2in2out_lpbk_results_wrwr/result_64K.txt
./2in2out_loopback 131072 	>>2in2out_lpbk_results_wrwr/result_128K.txt
./2in2out_loopback 262144 	>>2in2out_lpbk_results_wrwr/result_256K.txt
./2in2out_loopback 524288 	>>2in2out_lpbk_results_wrwr/result_512K.txt
./2in2out_loopback 1048576 	>>2in2out_lpbk_results_wrwr/result_1M.txt
#./debug_fir /dev/xillybus_read_32 /dev/xillybus_write_32 2097152 >> results/result_2M.txt
#./debug_fir /dev/xillybus_read_32 /dev/xillybus_write_32 4194304 >> results/result_4M.txt
#./debug_fir /dev/xillybus_read_32 /dev/xillybus_write_32 8388608 >> results/result_8M.txt
done
echo "Test completed"
