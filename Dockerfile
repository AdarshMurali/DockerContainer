# Use the official Azure Functions Python base image
FROM mcr.microsoft.com/azure-functions/python

# Set the working directory inside the container
WORKDIR /app

# Install required libraries for pyodbc and curl
RUN apt-get update \
    && apt-get install -y --no-install-recommends unixodbc-dev gcc curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt /
RUN python -m pip install --no-cache-dir -r /requirements.txt

# Copy the current directory contents into the container at /app
COPY . /app

# Set the Azure Functions Python worker to use Flask as the web framework
ENV AzureWebJobsScriptHost__Worker__Description__LanguageWorkers__Python__Arguments="--worker-python-worker-interpretor C:\\python38\\python.exe"

EXPOSE 80

# Specify the command to run your application (replace your_function_name with the name of your Python function file)
CMD ["func", "host", "start", "--port", "80", "--python", "your_function_name.py"]
