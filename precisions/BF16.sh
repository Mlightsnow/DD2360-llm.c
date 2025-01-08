# compile llm.c (mixed precision, with cuDNN flash-attention)
# first compilation is ~1 minute, mostly due to cuDNN
make train_gpt2cu PRECISION=BF16 
./train_gpt2cu -e gpt2_124M_bf16.bin -o BF16