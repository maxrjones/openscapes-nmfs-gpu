# Inherit from a JupyterHub compatible Docker image
FROM quay.io/jupyter/pytorch-notebook:cuda12-ubuntu-24.04

RUN echo ${NB_UID}
# Add conda packages
COPY environment.yml /tmp/environment.yml
RUN mamba env update --prefix ${CONDA_DIR} --file /tmp/environment.yml

# Install from main branches of zarr python
RUN python -m pip install --no-cache-dir \
    "zarr[optional,remote] @ git+https://github.com/zarr-developers/zarr-python.git"
