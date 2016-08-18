echo "Test Started"
rm -rf results
mkdir results

#50 iterations: In each iteration 18 different size of blocks are getting processed by HW accelerator 
for len in {1..50}
do
echo "Iteration $len"              
./test_lpthread 32 >> results/result_32.txt
./test_lpthread 64 >> results/result_64.txt
./test_lpthread 128 >> results/result_128.txt
./test_lpthread 256 >> results/result_256.txt
./test_lpthread 512 >> results/result_512.txt
./test_lpthread 1024 >> results/result_1K.txt
./test_lpthread 2048 >> results/result_2K.txt
./test_lpthread 4096 >> results/result_4K.txt
./test_lpthread 8192 >> results/result_8K.txt
./test_lpthread 16384 >> results/result_16K.txt
./test_lpthread 32768 >> results/result_32K.txt
./test_lpthread 65536 >> results/result_64K.txt
./test_lpthread 131072 >> results/result_128K.txt
./test_lpthread 262144 >> results/result_256K.txt
./test_lpthread 524288 >> results/result_512K.txt
./test_lpthread 1048576 >> results/result_1M.txt
#./debug_fir /dev/xillybus_read_32 /dev/xillybus_write_32 2097152 >> results/result_2M.txt
#./debug_fir /dev/xillybus_read_32 /dev/xillybus_write_32 4194304 >> results/result_4M.txt
#./debug_fir /dev/xillybus_read_32 /dev/xillybus_write_32 8388608 >> results/result_8M.txt
done
echo "Test completed"
