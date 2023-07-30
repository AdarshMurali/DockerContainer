# Use the official Ubuntu base image
FROM ubuntu:latest

# Set the working directory inside the container
WORKDIR /app

# Install required libraries for pyodbc and curl
RUN apt-get update \
    && apt-get install -y curl \
    && apt-get install -y --no-install-recommends unixodbc-dev gcc curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Download and install the Microsoft SQL Server ODBC Driver for Linux
RUN curl https://packages.microsoft.com/debian/11/prod/pool/main/m/msodbcsql17/msodbcsql17_17.9.1.1-1_amd64.deb -o msodbcsql.deb \
    && ACCEPT_EULA=Y dpkg -i msodbcsql.deb \
    && apt-get update \
    && apt-get install -y --no-install-recommends g++ \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* msodbcsql.deb

# Install Python and required libraries
RUN apt-get update \
    && apt-get install -y python3 python3-pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy the current directory contents into the container at /app
COPY . /app

# Install Python dependencies
RUN pip3 install --no-cache-dir -r requirements.txt

EXPOSE 5000

# Specify the command to run your application (replace app.py with the name of your Python script)
CMD ["python3", "app.py"]
