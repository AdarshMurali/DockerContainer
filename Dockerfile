# Use the official Python runtime as a base image
FROM python:3.8-slim

# Set the working directory inside the container
WORKDIR /app

# Install ODBC drivers and dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends unixodbc-dev gcc \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install required Python libraries
RUN pip install --no-cache-dir Flask pyodbc

# Copy the current directory contents into the container at /app
COPY . /app

# Set environment variables for SQL Server connection
ENV SQL_SERVER_HOST=portfoliorecomendation.database.windows.net
ENV SQL_DATABASE=Portfolio
ENV SQL_USERNAME=PortRecom
ENV SQL_PASSWORD=Portfolio@007

EXPOSE 5000

# Specify the command to run your application (replace app.py with the name of your Python script)
CMD ["python", "app.py"]
