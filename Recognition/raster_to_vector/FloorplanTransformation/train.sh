conda create --name floorplantransformation python=3.8
conda activate floorplantransformation
conda install pip
pip install -r requirements-no-version.txt
pip install torch==1.10.2+cu113 torchvision==0.11.3+cu113 -f https://download.pytorch.org/whl/cu113/torch_stable.html
python train.py --restore=1 --numEpochs=1000

