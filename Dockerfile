FROM pixpan/steamcmd-wincore AS installer
WORKDIR c:/AstroServer
RUN powershell $(steamcmd.exe +login anonymous +force_install_dir c:/AstroServer +app_update 728470 +quit; powershell exit 0)
COPY Astro ./Astro

FROM mcr.microsoft.com/windows:1909
ADD https://download.microsoft.com/download/6/A/A/6AA4EDFF-645B-48C5-81CC-ED5963AEAD48/vc_redist.x64.exe /vc_redist.x64.exe
RUN C:\vc_redist.x64.exe /quiet /install
WORKDIR /Server
COPY --from=installer c:/AstroServer .
EXPOSE 8777/udp
CMD AstroServer.exe && ping -t localhost