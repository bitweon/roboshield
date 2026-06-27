#!/bin/bash
mkdir -p reports
cat > "reports/report_$(date +%F).json" <<EOF
{"hostname":"$(hostname)","date":"$(date)"}
EOF
