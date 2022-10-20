# Inverse-Algorithmic-Design

Tool to convert floor plan images to code.
To run, go to `reconstruction`, install the necessary Julia packages, and run `julia InverseAlgorithmicDesign.jl`, which will the options to use the tool.

## Recognition

The Python code with the PyTorch models and vectorization mechanisms.
Some notebooks are also useful, such as `debug-brute-force.ipynb`, which was used to visualize the vectorization algorithm.
The `qualitative-results.ipynb` notebook was used to generate results for the qualitative evaluation of the system.
The code to generate images after the recognition process is complete on that notebook, not on `recognition.py`.

[The models' checkpoints to run this component are available here](https://drive.google.com/file/d/1Q-7QlcAJ2W6pFxYvO-GZ8Pnax3MRSaUT/view?usp=sharing).
The segmentation model `model_best_val_loss_var.pkl` is from [CubiCasa5K](https://github.com/CubiCasa/CubiCasa5k)

## Reconstruction

Julia program that uses [Conda.jl](https://github.com/JuliaPy/Conda.jl) to install the Python packages and calls the recognition component with [PyCall.jl](https://github.com/JuliaPy/PyCall.jl).
Then, $x$ and $y$ components for points are generated through hierarchical clustering and, finally, a new Julia program is written.
