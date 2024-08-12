#!/bin/bash

# Conda installation
if ! command -v conda &> /dev/null; then
	echo "Conda not found. Installing Miniconda..."

	mkdir -p ~/miniconda3

	wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
	bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3

	rm -rf ~/miniconda3/miniconda.sh

	~/miniconda3/bin/conda init bash
	~/miniconda3/bin/conda init zsh

	# wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh
	# bash miniconda.sh -b -p $HOME/miniconda
	# export PATH="$HOME/miniconda/bin:$PATH"
fi

# Verify if the "venv" Conda environment already exists
if conda env list | grep -q "venv"; then
	echo "The 'venv' environment already exists."
else
	echo "The 'venv' environment doest not exist. Creating the environment..."

	conda create -n venv
fi

conda activate venv

conda install pip

pip install -r requirements.txt

python app.py
