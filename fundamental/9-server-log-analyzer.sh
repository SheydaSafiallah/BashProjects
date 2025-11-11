#!/bin/bash

echo "*** Welcome to the Advanced Server Log Analyzer! ***"

read -p "Enter log file path: " logfile

if [ ! -f "$logfile" ] || [ ! -r "$logfile" ]; then
    echo "Error: File does not exist or is not readable."
    exit 1
fi

read -p "Enter output directory for the report: " report_dir

if [ ! -d "$report_dir" ]; then
    mkdir -p "$report_dir"
fi

report="$report_dir/server_log_report-$(date +%F-%H%M%S).txt"

echo "Analyzing log file..."

total=$(wc -l < "$logfile")
unique_ips=$(awk '{print $1}' "$logfile" | sort | uniq | wc -l)
top_urls=$(awk '{print $7}' "$logfile" | sort | uniq -c | sort -nr | head -5)
top_ips=$(awk '{print $1}' "$logfile" | sort | uniq -c | sort -nr | head -5)
status_2xx=$(awk '$9 ~ /^2/ {count++} END {print count+0}' "$logfile")
status_3xx=$(awk '$9 ~ /^3/ {count++} END {print count+0}' "$logfile")
status_4xx=$(awk '$9 ~ /^4/ {count++} END {print count+0}' "$logfile")
status_5xx=$(awk '$9 ~ /^5/ {count++} END {print count+0}' "$logfile")
clean_sample=$(sed 's/HTTP\/1.1/HTTP/' "$logfile" | head -10)

{
    echo "===== Server Log Report ====="
    echo "Log File: $logfile"
    echo "Report Generated: $(date)"
    echo
    echo "Total Requests: $total"
    echo "Unique IPs: $unique_ips"
    echo
    echo "Top 5 Requested URLs:"
    echo "$top_urls"
    echo
    echo "Top 5 Active IPs:"
    echo "$top_ips"
    echo
    echo "HTTP Status Codes:"
    echo "2xx (Success): $status_2xx"
    echo "3xx (Redirection): $status_3xx"
    echo "4xx (Client Error): $status_4xx"
    echo "5xx (Server Error): $status_5xx"
    echo
    echo "Sample Cleaned Log Lines:"
    echo "$clean_sample"
    echo "============================"
} > "$report"

echo "Report successfully generated at $report"

