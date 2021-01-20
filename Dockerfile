FROM mcr.microsoft.com/windows:10.0.17763.1040
# install chocolatey
RUN powershell Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Steamcmd is the headless steam install
RUN choco install -y steamcmd

# Astroneer server (UE5) requires visual studio c++ 2015 redistributable and DirectX
RUN choco install -y vcredist140
RUN choco install directx -y

# Just a cool web interface to control the server process
ADD https://github.com/ricky-davis/AstroLauncher/releases/download/v1.7.6/AstroLauncher.exe c:/astroneer/AstroLauncher.exe
WORKDIR c:/astroneer
COPY startup.bat .
VOLUME ["c:/astroneer/Astro/Saved"]
EXPOSE 5000
EXPOSE 7777/udp
ENTRYPOINT startup.bat