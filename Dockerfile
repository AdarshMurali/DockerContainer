# Use the official SQL Server image as a base
FROM mcr.microsoft.com/mssql/server:latest

# Set the working directory inside the container
WORKDIR /app

# Install required Python libraries
RUN apt-get update && apt-get install -y --no-install-recommends python3 python3-pip

# Install ODBC driver for SQL Server in the container
RUN apt-get update \
    && apt-get install -y --no-install-recommends curl gnupg2 \
    && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get install -y --no-install-recommends msodbcsql17

# Install required Python libraries
RUN pip install --no-cache-dir Flask pyodbc

# Copy the current directory contents into the container at /app
COPY . /app

# Set environment variables for SQL Server connection
ENV SQL_SERVER_HOST=portfoliorecomendation.database.windows.net
ENV SQL_DATABASE=Portfolio
ENV SQL_USERNAME=PortRecom
ENV SQL_PASSWORD=Portfolio@007
ENV ODBCSYSINI=/etc


EXPOSE 5000

# Specify the command to run your application (replace app.py with the name of your Python script)
CMD ["python", "app.py"]
