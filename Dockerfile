# 1. Use a specific, slim Python base for consistency across OS
FROM python:3.11-slim

# 2. Optimized Environment Variables for Mac/Docker Volume performance
# PYTHONDONTWRITEBYTECODE: Prevents .pyc files (cleaner volume mounts)
# PYTHONUNBUFFERED: Ensures logs appear in real-time in Mac terminal
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# 3. System Dependencies
# We keep Java as a backup but ensure we have build-essential 
# in case any Python libraries need to compile C-extensions on ARM/Mac.
RUN apt-get update && apt-get install -y --no-install-recommends \
    openjdk-17-jre-headless \
    wget \
    unzip \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# 4. Use a requirements.txt (Best practice for GitHub)
# This makes it easier for Mac users to see exactly what is being installed.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 5. Download RMLMapper (Backup engine)
RUN wget https://github.com/RMLio/rmlmapper-java/releases/download/v6.2.2/rmlmapper-6.2.2-r371-all.jar -O /opt/rmlmapper.jar

# 6. Project Structure
WORKDIR /app

# Copy the project files into the image (so it works even without volumes)
COPY . .

CMD ["bash"]
