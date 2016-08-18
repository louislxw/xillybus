echo "Test Started"
rm -rf results
mkdir results

#200 iterations: In each iteration 18 different size of blocks are getting processed by HW accelerator 
for len in {1..200}
do
echo "Iteration $len"              
./debug_fir 32 		>>results/result_32.txt
./debug_fir 64 		>>results/result_64.txt
./debug_fir 128 	>>results/result_128.txt
./debug_fir 256 	>>results/result_256.txt
./debug_fir 512 	>>results/result_512.txt
./debug_fir 1024	>>results/result_1K.txt
./debug_fir 2048 	>>results/result_2K.txt
./debug_fir 4096 	>>results/result_4K.txt
./debug_fir 8192 	>>results/result_8K.txt
./debug_fir 16384 	>>results/result_16K.txt
./debug_fir 32768 	>>results/result_32K.txt
./debug_fir 65536 	>>results/result_64K.txt
./debug_fir 131072	>>results/result_128K.txt
./debug_fir 262144	>>results/result_256K.txt
./debug_fir 524288	>>results/result_512K.txt
./debug_fir 1048576 	>>results/result_1M.txt
#./debug_fir /dev/xillybus_read_32 /dev/xillybus_write_32 2097152 >> results/result_2M.txt
#./debug_fir /dev/xillybus_read_32 /dev/xillybus_write_32 4194304 >> results/result_4M.txt
#./debug_fir /dev/xillybus_read_32 /dev/xillybus_write_32 8388608 >> results/result_8M.txt
done
echo "Test completed"
