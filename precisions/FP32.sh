make train_gpt2cu PRECISION=FP32
./train_gpt2cu -e gpt2_124M.bin -o FP32

# the default batch size is 4 and it requires 8GB of GPU memory
# adjust the batch size in the following command if you have less GPU memory
# ./train_gpt2cu -e gpt2_124M.bin -o FP32 -b 2
# ./train_gpt2cu -e gpt2_124M.bin -o FP32 -b 1