FROM mcr.microsoft.com/windows/servercore:ltsc2022 as installer

ARG NODE_VERSION

RUN powershell -Command \
    wget -Uri https://nodejs.org/dist/v%NODE_VERSION%/node-v%NODE_VERSION%-x64.msi -OutFile node.msi -UseBasicParsing ; \
    Start-Process -FilePath msiexec -ArgumentList /q, /i, node.msi -Wait ; \
    Remove-Item -Path node.msi


FROM mcr.microsoft.com/windows/nanoserver:ltsc2022

# Copy node.js
COPY --from=installer ["C:\\\\Program Files\\\\nodejs", "C:\\\\nodejs"]

ENTRYPOINT ["C:\\\\nodejs\\\\node.exe"]
