FROM python:3.11-slim

WORKDIR /app

# Copy requirements first to leverage cache
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application
COPY . .

# Expose the port (Railway sets PORT env var, but good practice to expose generic)
EXPOSE 5000

# Run the application directly
# Use gunicorn to run the application (production server)
# Ensure we bind to 0.0.0.0 and use the PORT environment variable
CMD gunicorn app:app --bind 0.0.0.0:$PORT
