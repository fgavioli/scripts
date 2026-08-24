#!/usr/bin/env bash
set -euf pipefail

sudo scripts/tftp-serve.mjs --root stage/xen/board-xen-smoke --port 69
