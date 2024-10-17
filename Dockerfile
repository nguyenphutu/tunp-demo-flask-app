# Use the official Python image
FROM python:3.9-slim

# Set working directory
WORKDIR /tunp-demo-flask-app

# Install dependencies
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

# Copy the rest of the application
COPY . .

# Expose the port Flask will run on
EXPOSE 5000

# Run the Flask app
CMD ["python", "app/app.py"]
