# syntax=docker/dockerfile:1

# Use the official Python image as the base image
ARG PYTHON_VERSION=3.11.5
FROM python:${PYTHON_VERSION}-slim as base

# Prevent Python from writing pyc files.
ENV PYTHONDONTWRITEBYTECODE=1

# Disable output buffering to see log messages immediately.
ENV PYTHONUNBUFFERED=1

# Set the working directory in the container
WORKDIR /app

# Create a non-privileged user for running the application
ARG UID=10001
RUN adduser --disabled-password --gecos "" --home "/nonexistent" --shell "/sbin/nologin" --no-create-home --uid "${UID}" appuser

# Install pipenv globally
RUN pip install pipenv

# Copy the Pipfile and Pipfile.lock to the container
COPY Pipfile Pipfile.lock ./

# Install dependencies using pipenv
RUN pipenv install --deploy --ignore-pipfile

# Copy your application code into the container
COPY . ./

# Expose the port that the application will listen on (you may need to adjust this based on your Flask app configuration)
EXPOSE 5000

# Run the application using pipenv
CMD ["pipenv", "run", "python", "app.py"]
