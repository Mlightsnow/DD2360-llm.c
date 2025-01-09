make train_gpt2cu PRECISION=BF16 
./train_gpt2cu -e gpt2_124M_bf16.bin -o BF16

# the default batch size is 4 and it requires 5GB of GPU memory
# adjust the batch size in the following command if you have less GPU memory
# ./train_gpt2cu -e gpt2_124M.bin -o FP16 -b 2
# ./train_gpt2cu -e gpt2_124M.bin -o FP16 -b 1