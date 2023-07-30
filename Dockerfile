# Use the official Microsoft SQL Server ODBC driver as a base image
FROM mcr.microsoft.com/azure-sql-edge

# Set the working directory inside the container
WORKDIR /app

# Create the required directories for package lists
RUN mkdir -p /var/lib/apt/lists/partial

# Install Python and required libraries
RUN apt-get update \
    && apt-get install -y python3 python3-pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install required libraries for pyodbc and curl
RUN apt-get update \
    && apt-get install -y --no-install-recommends unixodbc-dev gcc curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy the current directory contents into the container at /app
COPY . /app

# Install Python dependencies
RUN pip3 install --no-cache-dir -r requirements.txt

EXPOSE 5000

# Specify the command to run your application (replace app.py with the name of your Python script)
CMD ["python3", "app.py"]
