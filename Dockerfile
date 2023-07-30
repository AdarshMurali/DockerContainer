# Use the official Microsoft SQL Server ODBC driver as a base image
FROM mcr.microsoft.com/azure-sql-edge

# Use an official Python runtime as the second stage
FROM python:3.9-slim

# Set the working directory inside the container
WORKDIR /app

# Install required libraries for pyodbc
RUN apt-get update \
    && apt-get install -y curl \
    && apt-get install -y --no-install-recommends unixodbc-dev gcc \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy the current directory contents into the container at /app
COPY . /app

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 5000

# Specify the command to run your application (replace app.py with the name of your Python script)
CMD ["python", "app.py"]
