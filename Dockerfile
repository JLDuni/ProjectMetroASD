#DOCKERFILE
# Use an official lightweight Python image
#FROM python:3.14-slim

# Set working directory inside the container
#WORKDIR /app

# Copy dependency list first (to leverage Docker cache)
#COPY requirements.txt .

# Install dependencies
#RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of your project
#COPY . .

# Run linting or tests as part of CI
# (You can override this in the GitHub Actions command)
#CMD ["python", "src/main.py"]

FROM python:3.12-slim

WORKDIR /app

COPY src/ ./src/

EXPOSE 5000

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s \
  CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:5000/health')"

CMD ["python", "src/main.py"]