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

# Add the intial_run.sh script into the container
COPY intial_run.sh /intial_run.sh

# Ensure the intial_run.sh script has execute permissions
RUN chmod +x /intial_run.sh

# Add the startup.sh script into the container
COPY startup.sh /startup.sh

# Ensure the startup.sh script has execute permissions
RUN chmod +x /startup.sh
