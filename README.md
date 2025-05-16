# SelectZyme-demo-app
Minimal demonstration of pre-calculated analyses to show usage and utility of SelectZyme.

```mermaid
graph TD;  
    B[BLAST-PSI analysis] --> D[data/blast_psi/:/app/data_container/];
    C[Petase analysis] --> E[data/petase/:/app/data_container/];
    
    A[Proxy - Nginx] -->|/selectzyme-demo/blast-psi/| B[BLAST-PSI analysis];
    A[Proxy - Nginx] -->|/selectzyme-demo/petase/| C[Petase analysis];
    
    subgraph Docker Network;
        A[Proxy - Nginx];
        B[BLAST-PSI analysis];
        C[Petase analysis];
    end
```

## Install
Prerequisite for all installs is to clone the repository with the corresponding submodule SelectZyme.
```
git clone --recurse-submodules https://github.com/fmoorhof/SelectZyme-demo-app.git
cd SelectZyme-demo-app
```

### Docker
Requires cloning the repository (see above).
```
docker build -t ipb-halle/selectzyme-demo-app:development .
```
#### Run all case studies (reproduces SelectZyme server)
```
docker-compose up
docker-compose down  # shut down services
```
Access the server from your browser at: `localhost/selectzyme-demo/`


#### Run only individual Container
```
docker run -it --rm -p 8050:8050 ipb-halle/selectzyme-demo-app:development --input_dir=/app/data/blast_psi
```
Access the server for your analysis from your browser at: `localhost:8050`

### Local install
Install dependencies defined in the `pyproject.toml` and SelectZyme without dependencies.
```
pip install .
pip install --no-dependencies external/selectzyme/
```
Usage: 
```
python app.py  # runs example analysis by default
python app.py -i=/your/out_files/from/selectzyme_backend
```
Access the server for your analysis from your browser at: `localhost:8050`

## Development
This project uses the following tools to improve code quality:
- [ruff](https://docs.astral.sh/ruff/tutorial/)

## Server deployment
Target server: [biocloud](https://biocloud.ipb-halle.de/)
Service: [SelectZyme-demo](https://biocloud.ipb-halle.de/selectzyme-demo/)

Changes: Biocloud proxy sits on top of SelectZyme-demo proxy
```mermaid
sequenceDiagram
    actor User
    participant BP as Biocloud Proxy
    participant SDP as Selectzyme Demo Proxy (nginx)
    participant SDA as Selectzyme Demo App

    User->>+BP: Request resource
    BP->>+SDP: Forward request (e.g., to selectzyme-proxy.selectzyme-network)
    SDP->>+SDA: Proxy request to Selectzyme Demo App
    SDA-->>-SDP: App response
    SDP-->>-BP: Forward response
    BP-->>-User: Response
```

# License
MIT License