# Use a slim Python base
FROM python:3.11-slim

# Install Java, Ghostscript, and modern GL dependencies
RUN apt-get update && apt-get install -y \
    openjdk-21-jre-headless \
    ghostscript \
    python3-tk \
    libgl1 \
    libglx0 \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Install Transit Data Libraries
RUN pip install --no-cache-dir \
    pandas \
    camelot-py[cv] \
    rdflib \
    opencv-python-headless \
    pyshacl

# Download RMLMapper (Semantic Lift Engine)
RUN wget https://github.com/RMLio/rmlmapper-java/releases/download/v6.2.2/rmlmapper-6.2.2-r371-all.jar -O /opt/rmlmapper.jar

WORKDIR /app
CMD ["bash"]
