# Inherit from a JupyterHub compatible Docker image
FROM quay.io/jupyter/pytorch-notebook:cuda12-ubuntu-24.04

RUN mamba install jupyter-vscode-proxy git gh code-server<=4.96.4 hatch pre-commit
