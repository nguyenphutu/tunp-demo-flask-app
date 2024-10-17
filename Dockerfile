# Use the official Python image
FROM python:3.9-slim

# Set working directory
WORKDIR /var/lib/jenkins/workspace/tunp-demo-flask-app

# Copy requirements.txt and install dependencies
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

# Copy the entire application
COPY . /tunp-demo-flask-app

# Expose the port Flask runs on
EXPOSE 5000

# Run the Flask app
CMD ["python", "/tunp-demo-flask-app/app.py"]
