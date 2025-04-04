# Inherit from a JupyterHub compatible Docker image
FROM quay.io/jupyter/pytorch-notebook:cuda12-ubuntu-24.04

RUN echo ${NB_UID}
# Add conda packages
COPY environment.yml /tmp/environment.yml
RUN mamba env update --prefix ${CONDA_DIR} --file /tmp/environment.yml

COPY apt.txt /tmp/apt.txt

USER root

RUN apt-get update && \
    xargs -a /tmp/apt.txt apt install -y && \
    apt-get autoremove -y && \
    apt-get autoclean && \
    rm -rf /var/lib/apt/lists/* && \
    rm /tmp/apt.txt

# Install rustup
ENV RUSTUP_HOME="/opt/.rustup"
ENV CARGO_HOME="/opt/.cargo"
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="${CARGO_HOME}/bin:${PATH}"
RUN rustup component add rust-src

USER ${NB_UID}
# Update cargo home for users
ENV CARGO_HOME="${HOME}/.cargo"
ENV PATH="${CARGO_HOME}/bin:${PATH}"

# Install from main branches of key libraries
RUN python -m pip install --no-cache-dir \
    git+https://github.com/pydata/xarray.git \
    git+https://github.com/zarr-developers/zarr-python.git \
    git+https://github.com/zarr-developers/VirtualiZarr.git@develop \
    git+https://github.com/fsspec/kerchunk.git \
    git+https://github.com/earth-mover/icechunk#subdirectory=icechunk-python

RUN git clone -b gpu-codecs https://github.com/akshaysubr/zarr-python.git /opt/zarr-python && \
    cd /opt/zarr-python && \
    pip install .[gpu]
