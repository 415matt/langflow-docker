FROM python:3.10-slim

RUN apt-get update && apt-get install -y gcc g++ git make

# Create a non-root user and set environment variables
RUN useradd -m -u 1000 user
USER user
ENV HOME=/home/user \
    PATH=/home/user/.local/bin:$PATH

# Set the working directory
WORKDIR $HOME/app
COPY --chown=user . $HOME/app

# Install Python packages using pip
RUN pip install --user 'opentelemetry-sdk>=1.14.0,<1.20.0' langflow sentence-transformers


# Define the command to run when the container starts
CMD ["langflow", "--host", "0.0.0.0", "--port", "7860"]
