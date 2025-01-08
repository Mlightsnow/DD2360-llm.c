make train_gpt2cu PRECISION=FP16
./train_gpt2cu -e gpt2_124M_fp16.bin -o FP16 -l 0.000001

# default learning rate = 3e-4, to avoid overflow/underflow, reduce it to 1e-6