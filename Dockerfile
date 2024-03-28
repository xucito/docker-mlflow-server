FROM ghcr.io/mlflow/mlflow:v2.11.3

RUN apt-get -y update && \
    apt-get -y install python3-dev default-libmysqlclient-dev build-essential pkg-config && \
    pip install --upgrade pip && \
    pip install pyodbc && \
    apt install unixodbc

CMD ["bash"]
