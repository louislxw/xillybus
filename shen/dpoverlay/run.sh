echo "Test Started"
rm -rf results
mkdir results

#200 iterations: In each iteration 18 different size of blocks are getting processed by HW accelerator 
for len in {1..20}
do
echo "Iteration $len"              
./test 32 		>>result/result_32.txt
./test 64 		>>result/result_64.txt
./test 128 		>>result/result_128.txt
./test 256 		>>result/result_256.txt
./test 512 		>>result/result_512.txt
./test 1024		>>result/result_1K.txt
./test 2048 		>>result/result_2K.txt
./test 4096	 	>>result/result_4K.txt
./test 8192 		>>result/result_8K.txt
./test 16384 		>>result/result_16K.txt
./test 32768	 	>>result/result_32K.txt
./test 65536 		>>result/result_64K.txt
./test 131072		>>result/result_128K.txt
./test 262144		>>result/result_256K.txt
./test 524288		>>result/result_512K.txt
./test 1048576 		>>result/result_1M.txt
#./debug_fir /dev/xillybus_read_32 /dev/xillybus_write_32 2097152 >> results/result_2M.txt
#./debug_fir /dev/xillybus_read_32 /dev/xillybus_write_32 4194304 >> results/result_4M.txt
#./debug_fir /dev/xillybus_read_32 /dev/xillybus_write_32 8388608 >> results/result_8M.txt
done
echo "Test completed"
