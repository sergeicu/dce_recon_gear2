# Create Docker container that can run Gannet analyses.

# Start with the Matlab r2015b runtime container
FROM sergeicu/matlab-mcr:v96 

MAINTAINER Serge Vasylechko <serge.vasylechko@childrens.harvard.edu>

# Install dependencies
RUN apt-get update && apt-get install -y jq

# Make directory for flywheel spec (v0)
ENV FLYWHEEL /flywheel/v0/
RUN mkdir -p ${FLYWHEEL}

# ADD the Matlab Stand-Alone (MSA) binaries into the container.
# COPY matlab_binaries/reconstruct /bin/reconstruct
# COPY matlab_binaries/run_reconstruct.sh /bin/run_reconstruct.sh
COPY matlab_binaries/reconstruct ${FLYWHEEL}/reconstruct
COPY matlab_binaries/run_reconstruct.sh ${FLYWHEEL}/run_reconstruct.sh

# Copy and configure run script and metadata code
COPY run.sh ${FLYWHEEL}/run
COPY manifest.json ${FLYWHEEL}/manifest.json

# Ensure that the executable files are executable
RUN chmod +x ${FLYWHEEL}/*

# Configure entrypoint
ENTRYPOINT ["/flywheel/v0/run"]
