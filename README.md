# llm.c with different precisions


## Environment setup
```
# install miniconda
mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm -rf ~/miniconda3/miniconda.sh
~/miniconda3/bin/conda init bash
source ~/.bashrc

# pytorch nightly (optional) https://pytorch.org/get-started/locally/
# conda install --yes pytorch torchvision torchaudio pytorch-cuda=12.1 -c pytorch-nightly -c nvidia

# pip installs so we can tokenize the FineWeb dataset
yes | pip install -r requirements.txt

# install cudnn so we can use FlashAttention and run fast (optional)
# https://developer.nvidia.com/cudnn-downloads
# for me, CUDA 12 (run `nvcc --version`) running on Linux x86_64 Ubuntu 22.04
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb
sudo dpkg -i cuda-keyring_1.1-1_all.deb
sudo apt-get update
sudo apt-get -y install libcudnn9-dev-cuda-12

# "install" cudnn-frontend to ~/
git clone https://github.com/NVIDIA/cudnn-frontend.git

# install MPI (optional, if you intend to use multiple GPUs)
sudo apt install openmpi-bin openmpi-doc libopenmpi-dev

# download and tokenize the tinyshakespeare dataset
chmod u+x ./dev/download_starter_pack.sh
./dev/download_starter_pack.sh
```

## Compile and start training using scripts (Single GPU)
Generate .bin file as the gpt2 weight file. gpt2_124M.bin for FP32. gpt2_124M_fp16.bin for FP16. gpt2_124M_bf16.bin for BF16.
```
python train_gpt2.py
``` 

- FP32
```
./precisions/FP32.sh
```
- BF16
```
./precisions/BF16.sh
```
- FP16
```
./precisions/FP16.sh
```
Need at least 8GB GPU memory to run the FP32 training and 5GB for FP16 and BF16. You may adjust the batch size for GPU having small memory.

You can see the metrics results in terminal after training. And 'FP32', 'FP16', 'BF16' folders will be created to save the loss and norm every steps.

Use dev/vislog.ipynb to visualize the curve of loss and norm.

*.nsys-rep files save the profiling results of three different precisions training. You can open it on the Nsight systems GUI.
## quick start

The best introduction to the llm.c repo today is reproducing the GPT-2 (124M) model. [Discussion #481](https://github.com/karpathy/llm.c/discussions/481) steps through this in detail. We can reproduce other models from the GPT-2 and GPT-3 series in both llm.c and in the parallel implementation of PyTorch. Have a look at the [scripts README](scripts/README.md).

debugging tip: when you run the `make` command to build the binary, modify it by replacing `-O3` with `-g` so you can step through the code in your favorite IDE (e.g. vscode).

## reference
https://github.com/karpathy/llm.c