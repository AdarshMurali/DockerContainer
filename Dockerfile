# Use an official Python runtime as a parent image
FROM python:3.7

# Install FreeTDS and ODBC development libraries
RUN apt-get update && apt-get install -y tdsodbc unixodbc-dev && apt-get clean -y

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed packages specified in requirements.txt
RUN pip install -r requirements.txt

# Run app.py when the container launches
CMD ["python", "App.py"]
