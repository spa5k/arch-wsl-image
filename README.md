# Arch Linux WSL

This Dockerfile creates a minimal Arch Linux container with a new user and basic packages installed. It also sets up WSL and allows the new user to use sudo.

## Usage

1. Download the latest release rootfs.tar.gz from the [Releases](https://github.com/spa5k/arch-wsl-image/releases) page.
2. Import the rootfs.tar.gz file into WSL using the following command:

```
wsl --import -n arch -d  rootfs.tar.gz # Replace rootfs.tar.gz with the path to the rootfs.tar.gz file
```
3. Run the distribution:

```
wsl -d arch
```

4. Run the initial setup script:

```
chmod +x /scripts/initial_run.sh && /scripts/initial_run.sh
```

5. After adding your user, you can use the following command to start the WSL distribution:

```
wsl -d arch
```


### Building the Docker Image
To build the Docker image, run the following command:

```
docker build -t arch-wsl .
```

To run the container, use the following command:

```
docker run -it arch-wsl
```




## License

This project is licensed under the MIT License. See the LICENSE file for details.

