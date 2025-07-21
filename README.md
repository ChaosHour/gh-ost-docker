# Using Github's gh-ost for online schema changes in MySQL
This repository contains a Dockerfile and Makefile to build and manage a Docker image for `gh-ost`, a tool for performing online schema changes in MySQL databases.

## Example Usage

To run `gh-ost` with a custom MySQL configuration file, you can use the following command:

```bash
Prod Example:

docker run --rm \
  -v $(pwd)/my.cnf:/root/.my.cnf:ro \
  -v $(pwd)/gh-ost.log:/app/gh-ost.log \
  -v $(pwd)/schema_tools:/root/schema_tools \
  -w /app \
  gh-ost:latest \
  gh-ost --conf='/root/.my.cnf' \
    --max-load=Threads_running=50 \
    --critical-load=Threads_running=1000 \
    --chunk-size=1000 \
    --dml-batch-size=20 \
    --nice-ratio=1 \
    --max-lag-millis=1500 \
    --assume-master-host="192.168.50.75" \
    --host=192.168.50.75 \
    --database="widget_demo" \
    --table="WidgetEventLog" \
    --verbose \
    --alter="ADD COLUMN ad_distribution VARCHAR(50) COLLATE utf8_unicode_ci DEFAULT NULL, MODIFY COLUMN network VARCHAR(50) COLLATE utf8_unicode_ci NOT NULL" \
    --cut-over=default \
    --exact-rowcount \
    --concurrent-rowcount \
    --default-retries=120 \
    --assume-rbr \
    --allow-on-master \
    --gcp \
    --panic-flag-file=/root/schema_tools/ghost.panic.flag \
    --postpone-cut-over-flag-file=/root/schema_tools/ghost.postpone.flag \
    --execute 2>&1 | tee gh-ost.log
    ```



## Running gh-ost locally for testing
To run `gh-ost` locally with a custom MySQL configuration file, you can use
the following command:

```bash
docker run --rm \
  -v $(pwd)/my.cnf:/root/.my.cnf:ro \
  -v $(pwd)/gh-ost.log:/app/gh-ost.log \
  -v $(pwd)/schema_tools:/root/schema_tools \
  -w /app \
  gh-ost:latest \
  gh-ost --conf='/root/.my.cnf' \
    --max-load=Threads_running=50 \
    --critical-load=Threads_running=1000 \
    --chunk-size=1000 \
    --dml-batch-size=20 \
    --nice-ratio=1 \
    --max-lag-millis=1500 \
    --assume-master-host="192.168.50.75" \
    --host=192.168.50.75 \
    --database="widget_demo" \
    --table="WidgetEventLog" \
    --verbose \
    --alter="ADD COLUMN ad_distribution VARCHAR(50) COLLATE utf8_unicode_ci DEFAULT NULL, MODIFY COLUMN network VARCHAR(50) COLLATE utf8_unicode_ci NOT NULL" \
    --cut-over=default \
    --exact-rowcount \
    --concurrent-rowcount \
    --default-retries=120 \
    --assume-rbr \
    --allow-on-master \
    --gcp \
    --initially-drop-ghost-table \
    --initially-drop-old-table \
    --serve-socket-file=/root/schema_tools/ghost.sock \
    --panic-flag-file=/root/schema_tools/ghost.panic.flag \
    --postpone-cut-over-flag-file=/root/schema_tools/ghost.postpone.flag \
    --execute 2>&1 | tee gh-ost.log
```


## Running gh-ost in Kubernetes with Helm

This chart is designed to run a single pod (no HA). You can pass custom command-line arguments to `gh-ost` using the `args` field in `values.yaml` or via `--set args` on the command line.

Example Helm install with custom arguments:

```bash
helm install gh-ost ./gh-ost --namespace gh-ost \
  --set command="['gh-ost']" \
  --set args="['--conf=/root/.my.cnf','--max-load=Threads_running=50','--critical-load=Threads_running=1000','--chunk-size=1000','--dml-batch-size=20','--nice-ratio=1','--max-lag-millis=1500','--assume-master-host=192.168.50.75','--host=192.168.50.75','--database=widget_demo','--table=WidgetEventLog','--verbose','--alter=ADD COLUMN ad_distribution VARCHAR(50) COLLATE utf8_unicode_ci DEFAULT NULL, MODIFY COLUMN network VARCHAR(50) COLLATE utf8_unicode_ci NOT NULL','--cut-over=default','--exact-rowcount','--concurrent-rowcount','--default-retries=120','--assume-rbr','--allow-on-master','--panic-flag-file=/root/schema_tools/ghost.panic.flag','--postpone-cut-over-flag-file=/root/schema_tools/ghost.postpone.flag','--execute']"
```

Or edit `values.yaml`:

```yaml
replicaCount: 1
command: ["gh-ost"]
args:
  - "--conf=/root/.my.cnf"
  - "--max-load=Threads_running=50"
  - "--critical-load=Threads_running=1000"
  - "--chunk-size=1000"
  - "--dml-batch-size=20"
  - "--nice-ratio=1"
  - "--max-lag-millis=1500"
  - "--assume-master-host=192.168.50.75"
  - "--host=192.168.50.75"
  - "--database=widget_demo"
  - "--table=WidgetEventLog"
  - "--verbose"
  - "--alter=ADD COLUMN ad_distribution VARCHAR(50) COLLATE utf8_unicode_ci DEFAULT NULL, MODIFY COLUMN network VARCHAR(50) COLLATE utf8_unicode_ci NOT NULL"
  - "--cut-over=default"
  - "--exact-rowcount"
  - "--concurrent-rowcount"
  - "--default-retries=120"
  - "--assume-rbr"
  - "--allow-on-master"
  - "--panic-flag-file=/root/schema_tools/ghost.panic.flag"
  - "--postpone-cut-over-flag-file=/root/schema_tools/ghost.postpone.flag"
  - "--execute"
```

This approach lets you easily change arguments for each run.

## Building the Docker Image
To build the Docker image, run the following command:
```bash
make build
```

## Pushing the Docker Image
To push the Docker image to a registry, run:
```bash
make push
```

## Cleaning Up
To clean up the Docker builder instance, run:
```bash
make clean
```
