# Inherit from a JupyterHub compatible Docker image
FROM quay.io/jupyter/pytorch-notebook:cuda12-ubuntu-24.04

RUN echo ${NB_UID}
# Add conda packages
COPY environment.yml /tmp/environment.yml
RUN mamba env update --prefix ${CONDA_DIR} --file /tmp/environment.yml
