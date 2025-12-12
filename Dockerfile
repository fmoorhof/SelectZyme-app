# todo: The image contains 1 high vulnerability, consider action
FROM python:3.10-slim

# Set the working directory in the container
WORKDIR /app

RUN apt-get update \
    && apt-get install -y --no-install-recommends git \
    && rm -rf /var/lib/apt/lists/*

COPY pyproject.toml requirements.txt /app/

RUN \
    pip install --upgrade pip && \
    pip install uv && \
    uv sync && \
    uv pip install --no-cache-dir --no-deps git+https://github.com/ipb-halle/SelectZyme.git@1069532 && \
    uv run python -c "from huggingface_hub import snapshot_download; snapshot_download(repo_id='fmoorhof/selectzyme-app-data', repo_type='dataset')"

COPY . /app
RUN uv pip install .

# Expose the port Dash will run on
EXPOSE 8050

# Run the Dash app [stack size (-s) in kbytes] 
ENTRYPOINT ["bash", "-c", "ulimit -s 11040 && exec uv run gunicorn app:server --bind 0.0.0.0:8050 --workers 1"]
# ENTRYPOINT ["bash", "-c", "ulimit -s 10240 && exec python app.py \"$@\"", "--"]  # old argparsing
