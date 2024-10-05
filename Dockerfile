FROM archlinux:base-devel

# Copy all files from the current directory to the root directory of the container
COPY . /

# Copy the setup script into the container
COPY setup.sh /setup.sh

# Ensure the setup script has execute permissions
RUN chmod +x /setup.sh

# Run the setup script
RUN /setup.sh

# Remove the setup script to clean up
RUN rm /setup.sh

# Create a scripts directory
RUN mkdir -p /scripts

# Copy the initial_run.sh script into the scripts directory
COPY initial_run.sh /scripts/initial_run.sh

# Ensure the initial_run.sh script has execute permissions
RUN chmod +x /scripts/initial_run.sh

# Copy the startup.sh script into the scripts directory
COPY startup.sh /scripts/startup.sh

# Ensure the startup.sh script has execute permissions
RUN chmod +x /scripts/startup.sh