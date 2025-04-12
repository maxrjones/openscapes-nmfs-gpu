# Inherit from a JupyterHub compatible Docker image
FROM quay.io/jupyter/pytorch-notebook:cuda12-ubuntu-24.04

RUN mamba install git gh code-server pre-commit jupyter-vscode-proxy
