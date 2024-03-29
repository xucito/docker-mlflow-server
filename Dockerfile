FROM ghcr.io/mlflow/mlflow:v2.11.3

RUN apt-get -y update && \
    apt-get -y install python3-dev default-libmysqlclient-dev build-essential pkg-config unixodbc && \
    pip install --upgrade pip && \
    pip install pyodbc

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       apt-transport-https \
       curl \
       gnupg \
       unixodbc-dev \
    # Cleanup to keep the image tidy
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Add Microsoft's GPG key and repository for SQL Server ODBC Driver
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/debian/11/prod.list > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get install -y msodbcsql17 \
    # Another cleanup
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

CMD ["bash"]
