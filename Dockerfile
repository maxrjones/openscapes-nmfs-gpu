# Inherit from a JupyterHub compatible Docker image
FROM quay.io/jupyter/pytorch-notebook:cuda12-ubuntu-24.04

RUN mamba install cupy cupy-xarray boto3 earthaccess fsspec gcsfs
# Install from main branches of zarr python
RUN python -m pip install --no-cache-dir \
    "zarr[optional,remote] @ git+https://github.com/zarr-developers/zarr-python.git"
