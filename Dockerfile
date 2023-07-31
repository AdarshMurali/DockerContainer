# Use an official Python runtime as a base image
FROM python:3.8-slim-buster

# Set the working directory inside the container
WORKDIR /app

# Install ODBC drivers and dependencies
RUN apt-get update \
    && apt-get install -y curl gnupg2 unixodbc-dev gcc \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install ODBC driver for SQL Server in the container
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get install -y --no-install-recommends msodbcsql17

# Install Python dependencies
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
