FROM arm64v8/ros:jazzy

SHELL ["/bin/bash", "-c"]

# Erstelle Arbeitsverzeichnis für ROS2
WORKDIR /root/ros_ws/src

# Abhängigkeiten installieren
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    python3-colcon-common-extensions \
    python3-pip \
    build-essential \
    && rm -rf /var/lib/apt/lists/*


# Repo clonen (jazzy-Branch)
RUN git clone --recurse-submodules https://github.com/SpaceMaster85/precision_landing.git

# Baue ROS2 Workspace
WORKDIR /root/ros_ws

RUN . /opt/ros/$ROS_DISTRO/setup.sh && \
    apt-get update && rosdep update && \
    rosdep install --from-paths src --ignore-src -r -y

# Build
RUN . /opt/ros/$ROS_DISTRO/setup.sh && colcon build --symlink-install

COPY docker_entrypoint.sh /app/

# Kopiere das Startskript
COPY docker_entrypoint.sh /root/docker_entrypoint.sh
RUN chmod +x /root/docker_entrypoint.sh

# Standardbefehl zum Starten des Containers
CMD ["/root/docker_entrypoint.sh"]
