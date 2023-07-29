# Use an official Python runtime as a base image
FROM python:3.9-slim

# Set the working directory inside the container
WORKDIR /app

# Install ODBC drivers and dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends unixodbc-dev gcc \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install the ODBC driver for SQL Server (replace version and URL with the appropriate driver)
RUN curl https://download.microsoft.com/download/1/f/8/1f8f7dd4-805c-4e33-9c15-0c70f49916e4/msodbcsql17_17.9.1.1-1_amd64.deb -o msodbcsql.deb \
    && ACCEPT_EULA=Y dpkg -i msodbcsql.deb \
    && apt-get update \
    && apt-get install -y --no-install-recommends g++ \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* msodbcsql.deb
    
# Copy the current directory contents into the container at /app
COPY . /app

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 5000

# Specify the command to run your application (replace app.py with the name of your Python script)
CMD ["python", "app.py"]
