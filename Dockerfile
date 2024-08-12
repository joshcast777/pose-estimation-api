# Usa una imagen base con Ubuntu
FROM ubuntu:20.04

# Instala dependencias necesarias para Conda
RUN apt-get update && \
    apt-get install -y \
    wget \
    bzip2 \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Descarga e instala Miniconda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/conda && \
    rm Miniconda3-latest-Linux-x86_64.sh

# Configura Conda en el PATH
ENV PATH /opt/conda/bin:$PATH

# Crea el directorio de trabajo
WORKDIR /app

# Copia el archivo environment.yml al contenedor
# COPY environment.yml .

# Crea el entorno Conda y activa el entorno
RUN conda create -n venv && \
    conda clean --all -f -y

RUN conda activate venv && conda install pip && pip install -r requirements.txt

# Configura el entorno Conda para que esté activo
SHELL ["conda", "run", "-n", "myenv", "/bin/bash", "-c"]

# Copia el código fuente al contenedor
COPY . .

# Define el comando para ejecutar tu aplicación
CMD ["conda", "run", "-n", "myenv", "python", "app.py"]
