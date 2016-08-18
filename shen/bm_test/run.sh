echo "Test Started"
rm -rf results
mkdir results

#200 iterations: In each iteration 18 different size of blocks are getting processed by HW accelerator 
for len in {1..200}
do
echo "Iteration $len"              
./stencil_32 32 		>>stencil_results/result_32.txt
./stencil_32 64 		>>stencil_results/result_64.txt
./stencil_32 128 		>>stencil_results/result_128.txt
./stencil_32 256 		>>stencil_results/result_256.txt
./stencil_32 512 		>>stencil_results/result_512.txt
./stencil_32 1024		>>stencil_results/result_1K.txt
./stencil_32 2048 		>>stencil_results/result_2K.txt
./stencil_32 4096 		>>stencil_results/result_4K.txt
./stencil_32 8192 		>>stencil_results/result_8K.txt
./stencil_32 16384 		>>stencil_results/result_16K.txt
./stencil_32 32768 		>>stencil_results/result_32K.txt
./stencil_32 65536 		>>stencil_results/result_64K.txt
./stencil_32 131072		>>stencil_results/result_128K.txt
./stencil_32 262144		>>stencil_results/result_256K.txt
./stencil_32 524288		>>stencil_results/result_512K.txt
./stencil_32 1048576 		>>stencil_results/result_1M.txt
#./debug_fir /dev/xillybus_read_32 /dev/xillybus_write_32 2097152 >> results/result_2M.txt
#./debug_fir /dev/xillybus_read_32 /dev/xillybus_write_32 4194304 >> results/result_4M.txt
#./debug_fir /dev/xillybus_read_32 /dev/xillybus_write_32 8388608 >> results/result_8M.txt
done
echo "Test completed"
