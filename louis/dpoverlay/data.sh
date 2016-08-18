rm -rf table
mkdir table

./data results/result_32.txt >> table/data_32.txt
./data results/result_64.txt >> table/data_64.txt
./data results/result_128.txt >> table/data_128.txt
./data results/result_256.txt >> table/data_256.txt
./data results/result_512.txt >> table/data_512.txt
./data results/result_1K.txt >> table/data_1k.txt
./data results/result_2K.txt >> table/data_2k.txt
./data results/result_4K.txt >> table/data_4k.txt
./data results/result_8K.txt >> table/data_8k.txt
./data results/result_16K.txt >> table/data_16k.txt
./data results/result_32K.txt >> table/data_32k.txt
./data results/result_64K.txt >> table/data_64k.txt
./data results/result_128K.txt >> table/data_128k.txt
./data results/result_256K.txt >> table/data_256k.txt
./data results/result_512K.txt >> table/data_512k.txt
./data results/result_1M.txt >> table/data_1M.txt
